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
    private let userDefaultsManager: UserDefaultsManagerProtocol
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
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(didTabBookmakButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var TTSButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "speaker.wave.3"), for: .normal)
        button.addTarget(self, action: #selector(didTabTTSButton), for: .touchUpInside)
        
        return button
    }()
    
    init(book: String, kind: String, chapter: Int, verse: Int,userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()) {
        self.bookname = book
        self.bookkind = kind
        self.chapter = 1
        self.verse = 1
        self.userDefaultsManager = userDefaultsManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TTSManager.shared.synthesizer.delegate = self
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        animationView.isHidden = true //정답 이미지 기본 숨기기
        TTSButton.setImage(UIImage(systemName: "speaker.wave.3"), for: .normal) //스피커 기본 꺼짐
        
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
        let rightBarButtonItem1 = bookmarkButton
        rightBarButtonItem1.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        let rightItem1 = UIBarButtonItem(customView: rightBarButtonItem1)
        
        let rightBarButtonItem2 = TTSButton
        rightBarButtonItem2.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        let rightItem2 = UIBarButtonItem(customView: rightBarButtonItem2)
        
        navigationItem.setRightBarButtonItems([rightItem1, rightItem2], animated: true)
    }
    
    func setViews(chapter: Int, verse: Int, quoteText: String) {
        var bookLabelText: String {
            return bookname.localized + " \(chapter)\("chapter".localized) \(verse)\("verse".localized)"
        }
        bookNameLabel.text = bookLabelText
        
        var chpaterVerseLength: Int {
            return String(chapter).count + String(verse).count + 2 //"1:10 (장+절) + 공백+콜론 2 더함"
        }
        
        let startIdx: String.Index = quoteText.index(quoteText.startIndex, offsetBy: chpaterVerseLength) //장, 절 삭제

        var finalQuoteText = String(quoteText[startIdx...])
        finalQuoteText = finalQuoteText.replacingOccurrences(of: "(神)", with: "") //한자 삭제
        
        sourceQuoteLabel.text = finalQuoteText
    }
    
    func setBookmarked(_ isBookmark: Bool, _ isAlert: Bool) {
        if isBookmark {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            if isAlert {
                view.makeToast("BookmarkOn".localized)
            }
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            if isAlert {
                view.makeToast("BookmarkOff".localized)
            }
        }
    }
    
    func didNotCorrect() {
        view.makeToast("Wrong".localized)
        let url = Bundle.main.url(forResource: "wrongeffect", withExtension: "wav")
            if let unWrappedurl = url {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: unWrappedurl)
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
        animationView.isHidden = show ? false : true
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
        
        if bookmarkButton.currentImage == UIImage(systemName: "bookmark") {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            isBookmark = true
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            isBookmark = false
        }
        
        if let quote = sourceQuoteLabel.text {
            presenter.didTabBookmakButton(quote: quote, isBookmark: isBookmark)
        }
    }
    
    @objc func didTabTTSButton() {
        if TTSButton.currentImage == UIImage(systemName: "speaker.wave.3") {
            if let sourceQuoteString = sourceQuoteLabel.text {
                TTSButton.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
                TTSManager.shared.play(sourceQuoteString, userDefaultsManager.getLanguage())
            }
        } else {
            TTSButton.setImage(UIImage(systemName: "speaker.wave.3"), for: .normal)
            TTSManager.shared.stop()
        }
    }
}

extension TypingDetailViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        TTSButton.setImage(UIImage(systemName: "speaker.wave.3"), for: .normal)
        TTSManager.shared.stop()
    }
}

private extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}


