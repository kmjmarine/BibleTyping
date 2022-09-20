//
//  IntroPresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/09/20.
//

import Foundation

protocol IntroProtocol: AnyObject {
    func setupViews()
    func setMenuButtonTitle()
}

final class IntroPresenter {
    private weak var viewController: IntroProtocol?
    
    init(
        viewController: IntroProtocol
    ) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        viewController?.setMenuButtonTitle()
    }
}
