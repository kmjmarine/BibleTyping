//
//  TypingDetailViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import UIKit
import SnapKit
import Toast
import Lottie
import AVFoundation

final class TypingDetailViewController: UIViewController {
    private let bookkind: String
    private let bookname: String
    private var chapter: Int
    private var verse: Int
    private var audioPlayer: AVAudioPlayer?
    
    private lazy var presenter = TypingDetailPresenter(viewController: self, bookkind: bookkind, bookname: bookname, chapter: chapter, verse: verse)
    private let placeholderText = "EnterText".localized
    
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
        button.setTitle("Enter".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.TitleBrown, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTabConfirmButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel".localized, for: .normal)
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
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "correct")
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        
        return animationView
    }()
    
    private lazy var rigthBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "bookmark"),
        style: .plain,
        target: self,
        action: #selector(didTabBookmakButton)
    )
    
    init(book: String, kind: String, chapter: Int, verse: Int) {
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
        
        animationView.isHidden = true //정답 이미지 기본 숨기기
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
        [bookNameLabel, sourceQuoteLabel, writeQuoteTextView, buttonStackView, animationView]
            .forEach { view.addSubview($0) }
        
        let defaultSpacing: CGFloat = 24.0
        
        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(defaultSpacing)
            $0.centerX.equalToSuperview()
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
        
        animationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(writeQuoteTextView.snp.centerY)
            $0.height.equalTo(150.0)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = rigthBarButtonItem
    }
    
    func setViews(chapter: Int, verse: Int, quoteText: String) {
        bookNameLabel.text = bookname.localized + " \(chapter)\("chapter".localized) \(verse)\("verse".localized)"
        
        let startIdx: String.Index = quoteText.index(quoteText.startIndex, offsetBy: getMakeQuote(chapter, verse)) //장, 절 삭제

        var finalQuoteText = String(quoteText[startIdx...])
        finalQuoteText = finalQuoteText.replacingOccurrences(of: "(神)", with: "") //한자 삭제
        
        sourceQuoteLabel.text = finalQuoteText
    }
    
    func setBookmarked(_ isBookmark: Bool, _ isAlert: Bool) {
        if isBookmark {
            rigthBarButtonItem.image = UIImage(systemName: "bookmark.fill")
            if isAlert {
                view.makeToast("BookmarkOn".localized)
            }
        } else {
            rigthBarButtonItem.image = UIImage(systemName: "bookmark")
            view.makeToast("BookmarkOff".localized)
        }
    }
    
    func didNotCorrect() {
        view.makeToast("Wrong".localized)
        let url = Bundle.main.url(forResource: "wrongeffect", withExtension: "wav")
            if let url = url {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.prepareToPlay()
                    audioPlayer?.play()
                } catch {
                    print(error)
                }
            }
        UIDevice.vibrate()
    }
    
    func clearWriteQuoteTextView() {
        writeQuoteTextView.text = ""
    }
    
    func showCorrectAmnimationView(_ show: Bool) {
        if show {
            animationView.isHidden = false
        } else {
            animationView.isHidden = true
        }
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
    
    func showCloseAlertController() {
        let alertController = UIAlertController(title: "NoData".localized, message: nil, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "닫기", style: .destructive) {[weak self] _ in
            self?.dismiss(animated: true)
        }
        
        [closeAction].forEach { action in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
    
    func moveToTypingListViewController() {
        let typingDetailDoneViewController = TypingDetailDoneViewController(bookname: bookname)
        self.navigationController?.pushViewController(typingDetailDoneViewController, animated: false)
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
    
    @objc func didTabBookmakButton() {
        var isBookmark: Bool
        
        if rigthBarButtonItem.image == UIImage(systemName: "bookmark") {
            rigthBarButtonItem.image = UIImage(systemName: "bookmark.fill")
            isBookmark = true
        } else {
            rigthBarButtonItem.image = UIImage(systemName: "bookmark")
            isBookmark = false
        }
        
        if let quote = sourceQuoteLabel.text {
            presenter.didTabBookmakButton(quote: quote, isBookmark: isBookmark)
        }
    }
    
    //장:절 삭제 (1:10)
    func getMakeQuote(_ chapter: Int, _ verse: Int) -> Int {
        let chapterLength: Int = String(chapter).count
        let verseLength: Int = String(verse).count
        
        return chapterLength + verseLength + 2 //"1:10 (장+절) + 공백+콜론 2 더함"
    }
}

private extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}


