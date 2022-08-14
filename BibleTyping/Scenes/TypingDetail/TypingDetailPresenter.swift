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
    func setViews(chapter: Int, verse: Int, quoteText: String)
    func checkEqual(sourceText: String?, writeText: String?) -> Bool
    func clearWriteQuoteTextView()
}

final class TypingDetailPresenter: NSObject {
    private weak var viewController: TypingDetailProtocol?
    private let searchManager: SearchManagerProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    var bookkind: String
    var bookname: String
    var chapter: Int
    var verse: Int
    
    private var bible: [Bible] = []
    private var record: [Record] = []
    
    init(
        viewController: TypingDetailProtocol,
        searchManager: SearchManagerProtocol = SearchManager(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultManager(),
        bookkind: String,
        bookname: String,
        chapter: Int,
        verse: Int
    ) {
        self.viewController = viewController
        self.searchManager = searchManager
        self.userDefaultsManager = userDefaultsManager
        self.bookkind = bookkind
        self.bookname = bookname
        self.chapter = chapter
        self.verse = verse
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        let lastRecord: [Record]
        var lastChapter: Int = 1
        var lastVerse: Int = 1
 
        record = userDefaultsManager.getRecord()
        
        lastRecord = record.filter {
            $0.bookname == bookname
        }
        
        if let index = lastRecord.firstIndex(where: { $0.bookname == bookname }) {
            lastChapter = lastRecord[index].chapter
            lastVerse = lastRecord[index].verse + 1
        }
        
        let bookCode = setBook()
        
        SearchManager()
            .request(from: bookCode, chapter: lastChapter, verse: lastVerse) { quote in
              
                self.viewController?.setViews(chapter: lastChapter, verse: lastVerse, quoteText: quote)
            }

        self.chapter = lastChapter
        self.verse = lastVerse
    }
    
    func didNotCorrect() {
        viewController?.didNotCorrect()
    }
    
    func clearWriteQuoteTextView() {
        viewController?.clearWriteQuoteTextView()
    }
    
    func didCorrect(bookkind: String, bookname: String, chapter: Int, verse: Int) {
        userDefaultsManager.setRecord(Record(user: User.shared, bookkind: bookkind, bookname: bookname, chapter: chapter, verse: verse))
        
        self.viewWillAppear()
    }
    
    func didTabConfirmButton(sourceText: String?, writeText: String?) {
        let checkResult = viewController?.checkEqual(sourceText: sourceText, writeText: writeText)
        
        guard let checkResult = checkResult else { return }
        
        if !checkResult {
            didNotCorrect()
        } else {
            clearWriteQuoteTextView()
            didCorrect(bookkind: bookkind, bookname: bookname, chapter: chapter, verse: verse)
        }
    }
    
    func setBook() -> String {
        let bookCodes: [Bible]
        
        if self.bookkind == BookKind.old.rawValue {
            bookCodes = Bible.oldBible.filter {
                $0.bookName == self.bookname
            }
        } else {
            bookCodes = Bible.newBible.filter {
                $0.bookName == self.bookname
            }
        }
        
        var bookCode = bookCodes.map{ $0.bookCode }
        let setBookCode = bookCode[0].addString(someString: "kor-", position: "leading" )
        
        return setBookCode
    }
}
