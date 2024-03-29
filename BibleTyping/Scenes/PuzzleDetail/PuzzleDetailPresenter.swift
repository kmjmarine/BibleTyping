//
//  PuzzleDetailPresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/02.
//

import Foundation

protocol PuzzleDetailProtocol: AnyObject {
    func setupNavigationBar()
    func setupViews()
    func setup(randomIndex: [Int])
    func moveToPuzzleViewController()
}

final class PuzzleDetailPresenter: NSObject {
    private weak var viewController: PuzzleDetailProtocol?
    var quote: String
    
    init(viewController: PuzzleDetailProtocol, quote: String) {
        self.viewController = viewController
        self.quote = quote
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        let arrQuote: [String] = quote.components(separatedBy: " ")
        var randomIndex: [Int] = [ ]
        
        while randomIndex.count < 3 {
            let number = Int.random(in: 0..<arrQuote.count)
                    if !randomIndex.contains(number) {
                        randomIndex.append(number)
                    }
        }
        
        viewController?.setup(randomIndex: randomIndex.sorted())
    }
    
    func moveToPuzzleViewController() {
        viewController?.moveToPuzzleViewController()
    }
}
