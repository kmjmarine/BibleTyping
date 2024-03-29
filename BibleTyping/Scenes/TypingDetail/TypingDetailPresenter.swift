//
//  TypingDetailPresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import UIKit

protocol TypingDetailProtocol: AnyObject {
    func setupNavigationBar()
    func setupViews()
    func didNotCorrect()
    func setViews(chapter: Int, verse: Int, quoteText: String)
    func checkEqual(sourceText: String?, writeText: String?) -> Bool
    func clearWriteQuoteTextView()
    func showCorrectAmnimationView(_ show: Bool)
    func showCloseAlertController()
    func moveToTypingListViewController()
    func setBookmarked(_ isBookmark: Bool, _ isAlert: Bool)
}

final class TypingDetailPresenter: NSObject {
    private weak var viewController: TypingDetailProtocol?
    private let searchManager: SearchManagerProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private var timer: Timer?
    private var bookmark: [Bookmark] = []
    
    var bookkind: String
    var bookname: String
    var chapter: Int
    var verse: Int
    
    private var bible: [Bible] = []
    private var record: [Record] = []
    
    init(
        viewController: TypingDetailProtocol,
        searchManager: SearchManagerProtocol = SearchManager(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
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
        viewController?.setupNavigationBar()
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        let lastRecord: [Record]
        var lastChapter: Int = 1
        var lastVerse: Int = 1
        var doneChapter: Int = 1
        var doneVerse: Int = 1
        var completeChapter: Int = 1
        var completeVerse: Int = 1
 
        record = userDefaultsManager.getRecord()
        
        lastRecord = record.filter {
            $0.bookname == bookname
        }
        
        if let index = lastRecord.firstIndex(where: { $0.bookname == bookname }) {
            lastChapter = lastRecord[index].chapter
            lastVerse = lastRecord[index].verse + 1
        }
        
        guard
            let jsonData = loadBibleJson(),
            let bibleList = try? JSONDecoder().decode(BibleJson.self, from: jsonData)
        else { return }
        
        //해당 성경 마지막 장절 가져오기
        if let lastIndexJson = bibleList.Bibles.lastIndex(where: { $0.bookName == bookname }) {
            completeChapter = bibleList.Bibles[lastIndexJson].chapter
            completeVerse = bibleList.Bibles[lastIndexJson].verse
        }
        
        //현재 장의 마지막 장절 가져오기
        if let indexJson = bibleList.Bibles.firstIndex(where: { $0.bookName == bookname && $0.chapter == chapter }) {
            doneChapter = bibleList.Bibles[indexJson].chapter
            doneVerse = bibleList.Bibles[indexJson].verse
        }
        
        //마지막 장절 완료 시 TypingDetailDoneViewContoller로 push
        if lastChapter >= completeChapter && (lastVerse - 1) >= completeVerse {
            viewController?.moveToTypingListViewController()
        } else {
            var finalChapter: Int = 1
            var finalVerse: Int = 1
            
            //1장 마지막절 완료 시 2장 1절로 셋팅 처리
            if lastChapter == doneChapter && (lastVerse - 1) >= doneVerse {
                finalChapter += 1
                finalVerse = 1
            } else {
                finalChapter = lastChapter
                finalVerse = lastVerse
            }
            
            let bookCode = setBook()
            
            SearchManager()
                .request(from: bookCode, chapter: finalChapter, verse: finalVerse) { quote in
                    self.viewController?.setViews(chapter: finalChapter, verse: finalVerse, quoteText: quote)
                }

            self.chapter = finalChapter
            self.verse = finalVerse
        }
        
        //북마크 여부 처리
        bookmark = userDefaultsManager.getBookmark()
        if (bookmark.firstIndex(where: { $0.bookname == self.bookname && $0.chapter == self.chapter && $0.verse == self.verse
        }) != nil) {
            viewController?.setBookmarked(true, false)
        } else {
            viewController?.setBookmarked(false, false)
        }
    }
    
    func didNotCorrect() {
        viewController?.didNotCorrect()
    }
    
    func didCorrect(bookkind: String, bookname: String, chapter: Int, verse: Int) {
        userDefaultsManager.setRecord(Record(user: User.shared, bookkind: bookkind, bookname: bookname, chapter: chapter, verse: verse))
        
        viewController?.showCorrectAmnimationView(true)
        viewController?.clearWriteQuoteTextView()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2.2, target: self, selector: #selector(moveToViewWillAppear), userInfo: nil, repeats: false)
    }
    
    func didTabConfirmButton(sourceText: String?, writeText: String?) {
        let checkResult = viewController?.checkEqual(sourceText: sourceText, writeText: writeText)
        
        guard let checkResult = checkResult else { return }
        
        if !checkResult {
            didNotCorrect()
        } else {
            didCorrect(bookkind: bookkind, bookname: bookname, chapter: chapter, verse: verse)
        }
    }
    
    func didTabBookmakButton(quote: String, isBookmark: Bool) {
        bookmark = userDefaultsManager.getBookmark()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let current_date_string = formatter.string(from: Date())
        
        if isBookmark {
            //이미 북마크 되어 있는지 확인
            if (bookmark.firstIndex(where: { $0.bookname == self.bookname && $0.chapter == self.chapter && $0.verse == self.verse}) == nil) {
                userDefaultsManager.setBookmark(Bookmark(
                    bookname: self.bookname,
                    chapter: self.chapter,
                    verse: self.verse,
                    quote: quote,
                    date: current_date_string,
                    language: userDefaultsManager.getLanguage())
                    )
                    viewController?.setBookmarked(true, true)
                }
            } else {
                userDefaultsManager.delBookmark(Bookmark(
                    bookname: self.bookname,
                    chapter: self.chapter,
                    verse: self.verse,
                    quote: quote,
                    date: nil,
                    language: nil)
                    )
                    viewController?.setBookmarked(false, true)
            }
    }
    
    func setBook() -> String {
        let bookCodes: [Bible]
        let languageCode = userDefaultsManager.getLanguage()
        let setLanguageCode: String
        
        switch languageCode {
        case "ko":
            setLanguageCode = "kor-"
        case ("en"):
            setLanguageCode = "niv-"
        case ("ja"):
            setLanguageCode = "jco-"
        case ("zh"):
            setLanguageCode = "cus-"
        case("de"):
            setLanguageCode = "gsc-"
        case("fr"):
            setLanguageCode = "lsg-"
        default :
            setLanguageCode = "kor-"
        }
        
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
        let setBookCode = bookCode[0].addString(someString: setLanguageCode, position: "leading" )
        
        return setBookCode
    }
    
    func loadBibleJson() -> Data? {
        let fileNm: String = "jsonbible"
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else {
            viewController?.showCloseAlertController()
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            viewController?.showCloseAlertController()
            return nil
        }
    }
}

extension TypingDetailPresenter {
    @objc func moveToViewWillAppear() {
        self.viewWillAppear()
       
        viewController?.showCorrectAmnimationView(false)
    }
}
