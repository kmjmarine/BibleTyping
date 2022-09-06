//
//  TypingDetailDoneViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/28.
//

import UIKit
import SnapKit
import Lottie

final class TypingDetailDoneViewController: UIViewController {
    private let bookname: String
    
    private lazy var bookNameBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12.0
        
        return view
    }()
    
    private lazy var bookNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "congratulations")
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        
        return animationView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.TitleBrown, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTabConfirmButton), for: .touchUpInside)
        
        return button
    }()
    
    init(bookname: String) {
        self.bookname = bookname
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
}

extension TypingDetailDoneViewController {
    func setupViews() {
        [bookNameBaseView, bookNameLabel, animationView, confirmButton]
            .forEach { view.addSubview($0) }
        
        bookNameBaseView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(100.0)
        }
        
        bookNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(bookNameBaseView.snp.centerY)
            $0.leading.equalTo(bookNameBaseView.snp.leading).inset(24.0)
            $0.trailing.equalTo(bookNameBaseView.snp.trailing).inset(24.0)
        }
        
        animationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(200.0)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(animationView.snp.bottom).offset(80.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(50.0)
        }
    }
    
    func setViews() {
        bookNameLabel.text = bookname.localized + " " + "TypingDone".localized + "!"
    }
    
    @objc func didTabConfirmButton() {
        let typingListViewController = TypingListViewController()
        navigationController?.pushViewController(typingListViewController, animated: false)
    }
}
