//
//  PuzzlePresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/01.
//

import Foundation

protocol PuzzleProtocol: AnyObject {
    func setupViews()
    func setup(verse: String, verse_info: String)
}

final class PuzzlePresenter: NSObject {
    private weak var viewController: PuzzleProtocol?
    
    init(viewController: PuzzleProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        let languageCode = setLanguage()
        var quoteList: [Puzzle]
        
        switch languageCode {
        case "ko":
            quoteList = Puzzle.puzzleKOList
        case "en":
            quoteList = Puzzle.puzzleENList
        case "ja":
            quoteList = Puzzle.puzzleJAList
        case "zh":
            quoteList = Puzzle.puzzleZHList
        case "de":
            quoteList = Puzzle.puzzleDEList
        case "fr":
            quoteList = Puzzle.puzzleFRList
        default:
            quoteList = Puzzle.puzzleKOList
        }
        
        let quote = quoteList.randomElement()
        guard let verse = quote?.verse else { return }
        guard let verse_info = quote?.verse_info else { return }
        
        viewController?.setup(verse: verse, verse_info: verse_info)
    }
}

extension PuzzlePresenter {
    func setLanguage() -> String {
        var language = UserDefaults.standard.array(forKey: "language")?.first as? String //nil
        if language == nil {
            let str = String(NSLocale.preferredLanguages[0])    // 언어코드-지역코드 (ex. ko-KR, en-US)
            language = String(str.dropLast(3)) //ko, en으로 할당
        }
        
        return language!
    }
}
