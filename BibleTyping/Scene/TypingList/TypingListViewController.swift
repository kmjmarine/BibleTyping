//
//  TypingListViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/09.
//

import UIKit
import SnapKit

final class TypingListViewController: UIViewController {
    private lazy var presenter = TypingListPresenter(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension TypingListViewController: TypingListProtocol {
    
}
