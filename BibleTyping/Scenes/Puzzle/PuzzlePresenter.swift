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
        let quoteList: [Puzzle]
        quoteList = Puzzle.puzzleList
        
        let quote = quoteList.randomElement()
        guard let verse = quote?.verse else { return }
        guard let verse_info = quote?.verse_info else { return }
        
        viewController?.setup(verse: verse, verse_info: verse_info)
    }
}
