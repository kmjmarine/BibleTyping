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
        button.setTitle("BibleTyping", for: .normal)
        button.addTarget(self, action: #selector(moveToTypingListViewController), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var PuzzleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 28.0, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .TitleBrown
        button.layer.cornerRadius = 9.0
        button.setTitle("Quiz", for: .normal)
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
    
    private lazy var globalButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "globe.badge.chevron.backward"), for: .normal)
        button.addTarget(self, action: #selector(didTapGlobalButton), for: .touchUpInside)
        button.tintColor = .TitleBrown
        button.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .regular, scale: .default), forImageIn: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
        
        setMenuButtonTitle()
    }
    
    func setupViews() {
        [baseView, titleLabel, animationView, buttonStackView, versionLabel, globalButton]
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
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(width / 6.5)
        }
        
        animationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-35.0)
            $0.width.equalTo(width / 1.3)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(50.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(width / 4.5)
        }
        
        versionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(width / 30.0)
            $0.height.equalTo(35.0)
        }
        
        globalButton.snp.makeConstraints {
            $0.bottom.equalTo(versionLabel.snp.bottom)
            $0.trailing.equalTo(buttonStackView.snp.trailing)
            $0.width.equalTo(50.0)
            $0.height.equalTo(50.0)
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
    
    @objc func didTapGlobalButton() {
        let alertController = UIAlertController(title: "AlertTitle".localized, message: nil, preferredStyle: .actionSheet)
        let languageCode = setLanguage()
        var textColor: UIColor
        
        //한국어로 변경
        var action = UIAlertAction(title: "한국어", style: .default) { [weak self] _ in
            UserDefaults.standard.set(["ko"], forKey: "language")
            UserDefaults.standard.synchronize()
            
            self?.setMenuButtonTitle()
        }
        alertController.addAction(action)
        textColor = languageCode == "ko" ? UIColor.red : UIColor.label
        action.setValue(textColor, forKey: "titleTextColor")
        
        //영어로 변경
        action = UIAlertAction(title: "English", style: .default) { [weak self] _ in
            UserDefaults.standard.set(["en"], forKey: "language")
            UserDefaults.standard.synchronize()
            
            self?.setMenuButtonTitle()
        }
        alertController.addAction(action)
        textColor = languageCode == "en" ? UIColor.red : UIColor.label
        action.setValue(textColor, forKey: "titleTextColor")
        
        //중국어로 변경
        action = UIAlertAction(title: "中文", style: .default) { [weak self] _ in
            UserDefaults.standard.set(["zh"], forKey: "language")
            UserDefaults.standard.synchronize()
            
            self?.setMenuButtonTitle()
        }
        alertController.addAction(action)
        textColor = languageCode == "zh" ? UIColor.red : UIColor.label
        action.setValue(textColor, forKey: "titleTextColor")

        //일본어로 변경
        action = UIAlertAction(title: "日本語", style: .default) { [weak self] _ in
            UserDefaults.standard.set(["ja"], forKey: "language")
            UserDefaults.standard.synchronize()
            
            self?.setMenuButtonTitle()
        }
        textColor = languageCode == "ja" ? UIColor.red : UIColor.label
        action.setValue(textColor, forKey: "titleTextColor")
        
        //독일어로 변경
        action = UIAlertAction(title: "Deutsch", style: .default) { [weak self] _ in
            UserDefaults.standard.set(["de"], forKey: "language")
            UserDefaults.standard.synchronize()
            
            self?.setMenuButtonTitle()
        }
        alertController.addAction(action)
        textColor = languageCode == "de" ? UIColor.red : UIColor.label
        action.setValue(textColor, forKey: "titleTextColor")
        
        //프랑스어로 변경
        action = UIAlertAction(title: "Français", style: .default) { [weak self] _ in
            UserDefaults.standard.set(["fr"], forKey: "language")
            UserDefaults.standard.synchronize()
            
            self?.setMenuButtonTitle()
        }
        alertController.addAction(action)
        textColor = languageCode == "fr" ? UIColor.red : UIColor.label
        action.setValue(textColor, forKey: "titleTextColor")

        //취소
        let cancelAction = UIAlertAction(
            title: "Cancel".localized,
            style: .cancel,
            handler: nil
        )
        alertController.addAction(cancelAction)
        cancelAction.setValue(UIColor.blue, forKey: "titleTextColor")
        
        present(alertController, animated: true)
    }
}

extension IntroViewController {
    func setMenuButtonTitle() {
        self.TypingButton.setTitle("BibleTyping".localized, for: .normal)
        self.PuzzleButton.setTitle("Quiz".localized, for: .normal)
    }
    
    func setLanguage() -> String {
        var language = UserDefaults.standard.array(forKey: "language")?.first as? String //nil
        if language == nil {
            let str = String(NSLocale.preferredLanguages[0])    // 언어코드-지역코드 (ex. ko-KR, en-US)
            language = String(str.dropLast(3))
        }
        
        return language!
    }
}
