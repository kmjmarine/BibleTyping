//
//  TypingPresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import UIKit

protocol TypingProtocol: AnyObject {
    func setupViews()
    func didNotCorrect()
}

final class TypingPresenter: NSObject {
    private weak var viewController: TypingProtocol?
    private let searchManager: SearchManagerProtocol
    
    private var bible: [Bible] = []
    
    init(
        viewController: TypingProtocol,
        searchManager: SearchManagerProtocol = SearchManager()) {
        self.viewController = viewController
        self.searchManager = searchManager
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func didNotCorrect() {
        viewController?.didNotCorrect()
    }
}
