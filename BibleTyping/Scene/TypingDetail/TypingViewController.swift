//
//  TypingViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import UIKit
import SnapKit

//protocol TypingViewControllerDelegate: AnyObject {
//    func didEnterText(_ sourceText: String)
//}

final class TypingViewController: UIViewController {
    private lazy var presenter = TypingPresenter(viewController: self)
    private let placeholderText = NSLocalizedString("여기에 입력해 주세요", comment: "입력")
    //private weak var delegate: TypingViewControllerDelegate?
    
    private lazy var sourceQuoteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()

    private lazy var sourceQuoteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23.0, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var writeQuoteTextView: UITextView = {
        let textView = UITextView()
        textView.text = placeholderText
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 18.0, weight: .semibold)
        textView.returnKeyType = .done
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTabConfirmButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTabCancelButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        
        [confirmButton, cancelButton]
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchManager()
            .request(from: "kor-mat", chapter: 1, verse: 2) { quote in
                print(quote)
                
                self.sourceQuoteLabel.text = quote
                self.sourceQuoteLabel.textColor = .label
            }
        
        presenter.viewDidLoad()
    }
}

extension TypingViewController: UITextViewDelegate {
    //placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        //실행
        textView.text = nil
        textView.textColor = .label
    }
    
    //키보드 완료 탭시 뷰 닫기
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        
        self.writeQuoteTextView.text = text
        //delegate?.didEnterText(textView.text)
      
        return true
    }
}

extension TypingViewController: TypingProtocol {
    func setupViews() {
        [sourceQuoteView, sourceQuoteLabel, buttonStackView, writeQuoteTextView]
            .forEach { view.addSubview($0) }
        
        let defaultSpacing: CGFloat = 16.0
        
        sourceQuoteView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        sourceQuoteLabel.snp.makeConstraints {
            $0.top.equalTo(sourceQuoteView.snp.top).inset(24.0)
            $0.leading.equalTo(sourceQuoteView.snp.leading).inset(24.0)
            $0.trailing.equalTo(sourceQuoteView.snp.trailing).inset(24.0)
        }
        
        writeQuoteTextView.snp.makeConstraints {
            $0.top.equalTo(sourceQuoteLabel.snp.bottom).offset(24.0)
            $0.leading.equalTo(sourceQuoteLabel.snp.leading)
            $0.trailing.equalTo(sourceQuoteLabel.snp.trailing)
            $0.height.equalTo(200.0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(writeQuoteTextView.snp.bottom).offset(defaultSpacing)
            $0.leading.equalToSuperview().inset(defaultSpacing)
            $0.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50.0)
        }
    }
    
    @objc func didTabConfirmButton() {
        guard let sourceText = writeQuoteTextView.text else { return }
        //if sourceText.isEmpty { return }
        
        if sourceText != self.sourceQuoteLabel.text {
            presenter.didNotCorrect()
        }
        
        print(sourceText)
    }
    
    @objc func didTabCancelButton() {}
    
    
    func didNotCorrect() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "일치하지 않아요 틀린 부분을 수정해 주세요.", style: .default)
        alertController.addAction(action)
        
        let cancelAction = UIAlertAction(
            title: NSLocalizedString("확인", comment: "confirm"),
            style: .cancel,
            handler: nil
        )
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}


