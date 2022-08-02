//
//  PuzzleDetailPresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/02.
//

import Foundation

protocol PuzzleDetailProtocol: AnyObject {
    func setupViews()
    func setup(randomIndex: [Int])
}

final class PuzzleDetailPresenter: NSObject {
    private weak var viewController: PuzzleDetailProtocol?
    var quote: String
    
    init(viewController: PuzzleDetailProtocol, quote: String) {
        self.viewController = viewController
        self.quote = quote
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        let arrQuote: [String] = quote.components(separatedBy: " ")
        var randomIndex: [Int] = [ ]
        
        while randomIndex.count < 3 {
            let number = Int.random(in: 0...arrQuote.count - 1)
                    if !randomIndex.contains(number){
                        randomIndex.append(number)
                    }
                    //print(randomIndex.sorted())
        }
        
        viewController?.setup(randomIndex: randomIndex.sorted())
    }
}
