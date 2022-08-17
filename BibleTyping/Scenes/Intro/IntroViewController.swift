//
//  IntroViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/16.
//

import UIKit
import SnapKit

final class IntroViewController: UIViewController {
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        
        return view
    }()
    
    private lazy var TypingButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 28.0, weight: .bold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .TitleBrown
        button.layer.cornerRadius = 9.0
        button.setTitle("성경통독", for: .normal)
        button.addTarget(self, action: #selector(moveToTypingListViewController), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var PuzzleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 28.0, weight: .bold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .TitleBrown
        button.layer.cornerRadius = 9.0
        button.setTitle("구절맞추기", for: .normal)
        button.addTarget(self, action: #selector(moveToPuzzleViewController), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        
        [TypingButton, PuzzleButton]
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        [baseView, buttonStackView]
            .forEach { view.addSubview($0) }
        
        baseView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(50.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100.0)
        }
    }
}

extension IntroViewController {
    @objc func moveToTypingListViewController() {
        let typingViewController = TabbarController()
        typingViewController.selectedIndex = 0
        navigationController?.pushViewController(typingViewController, animated: false)
    }
    
    @objc func moveToPuzzleViewController() {
        let puzzleViewController = TabbarController()
        puzzleViewController.selectedIndex = 1
        navigationController?.pushViewController(puzzleViewController, animated: false)
    }
}
