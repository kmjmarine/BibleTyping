//
//  TypingDetailPresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import UIKit

protocol TypingDetailProtocol: AnyObject {
    func setupViews()
    func didNotCorrect()
    func setViews(with chpater: Int, verse: Int)
}

final class TypingDetailPresenter: NSObject {
    private weak var viewController: TypingDetailProtocol?
    private let searchManager: SearchManagerProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    var bookkind: String
    var bookname: String
    
    private var bible: [Bible] = [ ]
    private var record: [Record] = [ ]
    
    init(
        viewController: TypingDetailProtocol,
        searchManager: SearchManagerProtocol = SearchManager(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultManager(),
        bookkind: String,
        bookname: String
    ) {
        self.viewController = viewController
        self.searchManager = searchManager
        self.userDefaultsManager = userDefaultsManager
        self.bookkind = bookkind
        self.bookname = bookname
    }
    
    func viewWillAppear() {
        record = userDefaultsManager.getRecord()
    }
    
    func viewDidLoad() {
        let lastRecord: [Record]
        var lastChapter: Int = 1
        var lastVerse: Int = 1
        
        lastRecord = record.filter {
            $0.bookname == bookname
        }
        
        if let index = lastRecord.firstIndex(where: { $0.bookname == bookname }) {
            lastChapter = lastRecord[index].chapter
            lastVerse = lastRecord[index].verse
        }
        
        viewController?.setupViews()
        viewController?.setViews(with: lastChapter, verse: lastVerse)
    }
    
    func didNotCorrect() {
        viewController?.didNotCorrect()
    }
    
    func didCorrect(bookkind: String, bookname: String) {
        userDefaultsManager.setRecord(Record(user: User.shared, bookkind: bookkind, bookname: bookname, chapter: 1, verse: 2))
    }
}
