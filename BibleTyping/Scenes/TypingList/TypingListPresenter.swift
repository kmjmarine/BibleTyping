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
    func pushToTypingViewController(book: String)
}

final class TypingListPresenter:NSObject {
    private weak var viewController: TypingListProtocol?
    
    private var oldBible: [Bible] = []
    private var newBible: [Bible] = []
    
    init(viewController: TypingListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
    }
    
    func viewWillAppear() {
        oldBible = Bible.oldBible
        newBible = Bible.newBible
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

        if collectionView.tag == 1 {
            kindBible = oldBible
        }

        if collectionView.tag == 2 {
            kindBible = newBible
        }
            return kindBible.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypingListCollectionViewCell.identifier, for: indexPath) as? TypingListCollectionViewCell
        
        var kindBible: Bible? = nil
        
        if collectionView.tag == 1 {
            kindBible = oldBible[indexPath.item]
        }
        
        if collectionView.tag == 2 {
            kindBible = newBible[indexPath.item]
        }
       
        cell?.setup(bible: kindBible!)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        var listBible: Bible? = nil
        
        if collectionView.tag == 1 {
            listBible = oldBible[indexPath.item]
        }
        
        if collectionView.tag == 2 {
            listBible = newBible[indexPath.item]
        }
        
        viewController?.pushToTypingViewController(book: listBible?.book ?? "")
    }
}
