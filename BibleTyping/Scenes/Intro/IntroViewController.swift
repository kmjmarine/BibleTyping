//
//  IntroViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/16.
//

import UIKit
import SnapKit
import Lottie

final class IntroViewController: UIViewController {
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "BIBLE TYPING"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 45.0, weight: .heavy)
        
        return label
    }()
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "intro")
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        
        return animationView
    }()
    
    private lazy var TypingButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 28.0, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .TitleBrown
        button.layer.cornerRadius = 9.0
        button.setTitle("성경통독", for: .normal)
        button.addTarget(self, action: #selector(moveToTypingListViewController), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var PuzzleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 28.0, weight: .bold)
        button.setTitleColor(.white, for: .normal)
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
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.text = "v2.2"
        label.textColor = .TitleBrown
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupViews() {
        [baseView, titleLabel, animationView, buttonStackView, versionLabel]
            .forEach { view.addSubview($0) }
            
        guard let info = Bundle.main.infoDictionary,
                  let currentVersion = info["CFBundleShortVersionString"] as? String else { return }
        versionLabel.text = "v" + currentVersion
        
        let width = UIScreen.main.bounds.width
        
        baseView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
        }
        
        animationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-45.0)
            $0.width.equalTo(width / 1.3)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(50.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(110.0)
        }
        
        versionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(60.0)
        }
    }
}

extension IntroViewController {
    @objc func moveToTypingListViewController() {
        let typingViewController = TabbarController()
        typingViewController.selectedIndex = 1
        navigationController?.pushViewController(typingViewController, animated: false)
    }
    
    @objc func moveToPuzzleViewController() {
        let puzzleViewController = TabbarController()
        puzzleViewController.selectedIndex = 2
        navigationController?.pushViewController(puzzleViewController, animated: false)
    }
}
