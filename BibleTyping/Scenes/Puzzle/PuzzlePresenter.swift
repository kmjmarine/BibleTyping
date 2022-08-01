//
//  PuzzlePresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/01.
//

import Foundation

protocol PuzzleProtocol: AnyObject {
    
}

final class PuzzlePresenter: NSObject {
    private weak var viewController: PuzzleProtocol?
    
    init(viewController: PuzzleProtocol) {
        self.viewController = viewController
    }
}
