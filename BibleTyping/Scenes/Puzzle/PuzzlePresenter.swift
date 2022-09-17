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
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(
        viewController: PuzzleProtocol,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        let languageCode = userDefaultsManager.getLanguage()
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

