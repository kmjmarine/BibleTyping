//
//  TypingDetailViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import UIKit
import SnapKit
import Toast

//protocol TypingViewControllerDelegate: AnyObject {
//    func didEnterText(_ sourceText: String)
//}

final class TypingDetailViewController: UIViewController {
    private let bookkind: String
    private let bookname: String
    private var chapter: Int
    private var verse: Int
    
    private lazy var presenter = TypingDetailPresenter(viewController: self, bookkind: bookkind, bookname: bookname, chapter: chapter, verse: verse)
    private let placeholderText = NSLocalizedString("여기에 입력해 주세요", comment: "입력")
    //private weak var delegate: TypingViewControllerDelegate?
    
    private lazy var bookNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()

    private lazy var sourceQuoteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23.0, weight: .bold)
        label.lineBreakMode = .byCharWrapping
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
        
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.TitleBrown?.cgColor ??
        UIColor.systemBrown.cgColor
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.TitleBrown, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTabConfirmButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.TitleBrown, for: .normal)
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
    
    init(book: String, kind: String, chpater: Int, verse: Int) {
        self.bookname = book
        self.bookkind = kind
        self.chapter = 1
        self.verse = 1
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        presenter.viewWillAppear()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension TypingDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
    
    //키보드 완료 탭 시 키보드 내리기
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        
        presenter.didTabConfirmButton(sourceText: sourceQuoteLabel.text, writeText: writeQuoteTextView.text)
        
        textView.resignFirstResponder()
        
        return true
    }
}

extension TypingDetailViewController: TypingDetailProtocol {
    func setupViews() {
        [bookNameLabel, sourceQuoteLabel, writeQuoteTextView, buttonStackView]
            .forEach { view.addSubview($0) }
        
        let defaultSpacing: CGFloat = 24.0
        
        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(defaultSpacing)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        sourceQuoteLabel.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(24.0)
            $0.leading.equalTo(bookNameLabel.snp.leading).inset(16.0)
            $0.trailing.equalTo(bookNameLabel.snp.trailing).inset(16.0)
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
    
    func setViews(chapter: Int, verse: Int, quoteText: String) {
        bookNameLabel.text = bookname + " \(chapter)장 \(verse)절"
        
        let startIdx: String.Index = quoteText.index(quoteText.startIndex, offsetBy: getMakeQuote(chapter, verse)) //장, 절 삭제

        let finalQuoteText = String(quoteText[startIdx...])
        
        sourceQuoteLabel.text = finalQuoteText
    }
    
    func didNotCorrect() {
        view.makeToast("틀린 부분이 있어요. 수정 후 다시 저장해 주세요.")
    }
    
    func clearWriteQuoteTextView() {
        writeQuoteTextView.text = ""
    }
    
    func checkEqual(sourceText: String?, writeText: String?) -> Bool {
        var checkReturn: Bool
        
        guard let sourceText = sourceText else {
            return false
        }
        
        guard let writeText = writeText else {
            return false
        }

        let arrWriteText = writeText.map { $0 }
        let arrSourceText = sourceText.map { $0 }
        
        if arrWriteText.count > arrSourceText .count {
            checkReturn = false
        } else {
            var compareWriteCharacter: String = ""
            var compareSourceCharacter: String = ""
            
            let attribtuedString = NSMutableAttributedString(string: writeText)
            
            for chrSourceText in arrWriteText.indices {
                compareWriteCharacter = String(arrWriteText[chrSourceText])
                compareSourceCharacter = String(arrSourceText[chrSourceText])
                         
                if compareWriteCharacter != compareSourceCharacter {
                    attribtuedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemRed, range: NSRange(location: chrSourceText, length: 1))
                    attribtuedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: writeQuoteTextView.font!.pointSize), range: NSRange(location: 0, length: writeText.count))
                } else {
                    attribtuedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.label, range: NSRange(location: chrSourceText, length: 1))
                    attribtuedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: writeQuoteTextView.font!.pointSize), range: NSRange(location: 0, length: writeText.count))
                }
            }
            
            writeQuoteTextView.attributedText = attribtuedString
            
            checkReturn = sourceText == writeText ? true : false
        }
        
        return checkReturn
    }
}

private extension TypingDetailViewController {
    @objc func didTabConfirmButton() {
        presenter.didTabConfirmButton(sourceText: sourceQuoteLabel.text, writeText: writeQuoteTextView.text)
        self.view.endEditing(true)
    }
    
    @objc func didTabCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //장:절 삭제 (1:10)
    func getMakeQuote(_ chpater: Int, _ verse: Int) -> Int {
        let chapterLength: Int = String(chpater).count
        let verseLength: Int = String(verse).count
        
        return chapterLength + verseLength + 2 //"1:10 (장+절) + 공백+콜론 2 더함"
    }
}


