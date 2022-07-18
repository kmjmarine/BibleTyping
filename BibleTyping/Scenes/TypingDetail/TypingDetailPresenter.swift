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
}

final class TypingDetailPresenter: NSObject {
    private weak var viewController: TypingDetailProtocol?
    private let searchManager: SearchManagerProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var bible: [Bible] = [ ]
    private var record: [Record] = [ ]
    
    init(
        viewController: TypingDetailProtocol,
        searchManager: SearchManagerProtocol = SearchManager(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultManager()) {
        self.viewController = viewController
        self.searchManager = searchManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewWillAppear() {
        record = userDefaultsManager.getRecord()
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func didNotCorrect() {
        viewController?.didNotCorrect()
    }
    
    func didCorrect(bookkind: String, bookname: String) {
        userDefaultsManager.setRecord(Record(user: User.shared, bookkind: bookkind, bookname: bookname, chapter: 1, verse: 2))
    }
}
