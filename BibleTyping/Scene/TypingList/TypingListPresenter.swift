//
//  TypingListPresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/09.
//

import Foundation

protocol TypingListProtocol: AnyObject {
    
}

final class TypingListPresenter:NSObject {
    private weak var viewController: TypingListProtocol?
    
    init(viewController: TypingListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
    
    }
}
