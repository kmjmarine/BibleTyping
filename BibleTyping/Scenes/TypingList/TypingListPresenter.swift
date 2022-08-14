//
//  TypingListPresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/09.
//

import Foundation
import UIKit

protocol TypingListProtocol: AnyObject {
    func setupView()
    func pushToTypingViewController(book: String, kind: String)
}

final class TypingListPresenter: NSObject {
    private weak var viewController: TypingListProtocol?
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var oldBible: [Bible] = []
    private var newBible: [Bible] = []
    private var record: [Record] = []
    
    init(
         viewController: TypingListProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setupView()
    }
    
    func viewWillAppear() {
        oldBible = Bible.oldBible
        newBible = Bible.newBible
        
        record = userDefaultsManager.getRecord()
    }
}

extension TypingListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16.0
        let width: CGFloat = (collectionView.frame.width - spacing * 4) / 3
        return CGSize(width: width, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

extension TypingListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var kindBible: [Bible] = []
        kindBible = collectionView.tag == 1 ? oldBible : newBible
        
        return kindBible.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypingListCollectionViewCell.identifier, for: indexPath) as? TypingListCollectionViewCell
        
        var kindBible: Bible? = nil
        kindBible = collectionView.tag == 1 ? oldBible[indexPath.item] : newBible[indexPath.item]
        
        //Reocord
        let lastRecord: [Record]
        var lastChapter: Int = 0
        var lastVerse: Int = 0
        
        lastRecord = record.filter {
            $0.bookname == kindBible?.bookName
        }
        
        if let index = lastRecord.firstIndex(where: { $0.bookname == kindBible?.bookName
        }) {
            lastChapter = lastRecord[index].chapter
            lastVerse = lastRecord[index].verse + 1
        }
        
        cell?.setup(bible: kindBible!)
        cell?.setupStatusButton(lastChapter, lastVerse)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var listBible: Bible? = nil
        var kindBible: String = ""
        
        listBible = collectionView.tag == 1 ? oldBible[indexPath.item] : newBible[indexPath.item]
        kindBible = collectionView.tag == 1 ? BookKind.old.rawValue : BookKind.new.rawValue
        
        viewController?.pushToTypingViewController(book: listBible?.bookName ?? "", kind: kindBible)
    }
}
