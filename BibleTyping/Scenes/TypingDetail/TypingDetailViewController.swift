//
//  TypingDetailViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import UIKit
import SnapKit

//protocol TypingViewControllerDelegate: AnyObject {
//    func didEnterText(_ sourceText: String)
//}

final class TypingDetailViewController: UIViewController {
    private let bookkind: String
    private let bookname: String
    private var chapter: Int
    private var verse: Int
    
    private lazy var presenter = TypingDetailPresenter(viewController: self, bookkind: bookkind, bookname: bookname)
    private let placeholderText = NSLocalizedString("여기에 입력해 주세요", comment: "입력")
    //private weak var delegate: TypingViewControllerDelegate?
    
    private lazy var bookNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        //label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.text = bookname + " 1장"
        
        return label
    }()
    
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
        super.viewWillAppear(animated)
        
        let bookCode = setBook()
        
        SearchManager()
            .request(from: bookCode, chapter: chapter, verse: verse) { quote in
                //print(quote)
              
                self.sourceQuoteLabel.text = quote
                self.sourceQuoteLabel.textColor = .label
            }
        
        presenter.viewWillAppear()
    }
}

extension TypingDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
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

extension TypingDetailViewController: TypingDetailProtocol {
    func setupViews() {
        [bookNameLabel, sourceQuoteView, sourceQuoteLabel, buttonStackView, writeQuoteTextView]
            .forEach { view.addSubview($0) }
        
        let defaultSpacing: CGFloat = 16.0
        
        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        sourceQuoteView.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(24.0)
            $0.leading.equalTo(bookNameLabel.snp.leading)
            $0.trailing.equalTo(bookNameLabel.snp.trailing)
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
        guard let sourceText = self.sourceQuoteLabel.text else { return }
        guard let writeText = self.writeQuoteTextView.text else { return }
        
        let checkResult = checkEqual(sourceText: sourceText, writeText: writeText)
        
        if !checkResult {
            presenter.didNotCorrect()
        } else {
            presenter.didCorrect(bookkind: bookkind, bookname: bookname)
        }
    }
    
    @objc func didTabCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
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
    
    func setViews(with chapter: Int, verse: Int) {
        self.chapter = chapter
        self.verse = verse + 1
    }
}

private extension TypingDetailViewController {
    func checkEqual(sourceText: String, writeText: String) -> Bool {
        var checkReturn: Bool
        
        let arrWriteText = writeText.map { $0 }
        let arrSourceText = sourceText.map { $0 }
        
        var compareWriteCharacter: String = ""
        var compareSourceCharacter: String = ""
        
        let attribtuedString = NSMutableAttributedString(string: writeText)
        
        for chrSourceText in arrWriteText.indices {
            compareWriteCharacter = String(arrWriteText[chrSourceText])
            compareSourceCharacter = String(arrSourceText[chrSourceText])
                     
            if compareWriteCharacter != compareSourceCharacter {
                attribtuedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemRed, range: NSRange(location: chrSourceText, length: 1))
                attribtuedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: self.writeQuoteTextView.font!.pointSize), range: NSRange(location: 0, length: writeText.count))
                self.writeQuoteTextView.attributedText = attribtuedString
            }
        }
        
        checkReturn = sourceText == writeText ? true : false
        
        return checkReturn
    }
    
    func setBook() -> String {
        let bookCodes: [Bible]
        
        if self.bookkind == BookKind.old.rawValue {
            bookCodes = Bible.oldBible.filter {
                $0.bookName == self.bookname
            }
        } else {
            bookCodes = Bible.newBible.filter {
                $0.bookName == self.bookname
            }
        }
        
        var bookCode = bookCodes.map{ $0.bookCode }
        let setBookCode = bookCode[0].addString(someString: "kor-", position: "leading" )
        
        return setBookCode
    }
}

