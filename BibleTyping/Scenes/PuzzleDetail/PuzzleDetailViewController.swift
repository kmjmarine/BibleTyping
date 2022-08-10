//
//  PuzzleDetailViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/02.
//

import UIKit
import SnapKit
import Toast
import Lottie

final class PuzzleDetailViewController: UIViewController {
    private lazy var presenter = PuzzleDetailPresenter(viewController: self, quote: verse)
    private var verse: String = ""
    private var verse_info: String = ""
    private var setVerse1: String = ""
    private var setVerse2: String = ""
    private var setVerse3: String = ""
    private var doneVerse1: Bool = false
    private var doneVerse2: Bool = false
    private var doneVerse3: Bool = false
    private var timer: Timer?
    
    private lazy var rigthBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "arrow.clockwise"),
        style: .plain,
        target: self,
        action: #selector(moveToPuzzleViewController)
    )
    
    private lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .regular)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var infoBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12.0
        
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var randomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25.0, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name:"success")
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        
        return animationView
    }()
    
    private lazy var randomVerseButton1: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector
                         (setRandomLabelText1), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var randomVerseButton2: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(setRandomLabelText2), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var randomVerseButton3: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(setRandomLabelText3), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        
        [randomVerseButton1 ,randomVerseButton2, randomVerseButton3]
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    init(verse: String, verse_info: String) {
        self.verse = verse
        self.verse_info = verse_info
        
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
        
        animationView.isHidden = true //정답 이미지 기본 숨기기
        presenter.viewWillAppear()
    }
}

extension PuzzleDetailViewController: PuzzleDetailProtocol {
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = rigthBarButtonItem
    }
    
    func setupViews() {
        [explainLabel, infoBaseView, infoLabel, randomLabel, animationView, buttonStackView]
            .forEach { view.addSubview($0) }
        
        let bottomSpacing: CGFloat = (tabBarController?.tabBar.frame.height)!
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(30.0)
        }
        
        infoBaseView.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(bottomSpacing * 5.0)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(infoBaseView.snp.top).inset(16.0)
            $0.leading.equalTo(infoBaseView.snp.leading).inset(16.0)
            $0.trailing.equalTo(infoBaseView.snp.trailing).inset(16.0)
        }
        
        randomLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(16.0)
            $0.leading.equalTo(infoBaseView.snp.leading).inset(16.0)
            $0.trailing.equalTo(infoBaseView.snp.trailing).inset(16.0)
        }
        
        animationView.snp.makeConstraints {
            //$0.top.equalTo(infoBaseView.snp.bottom).offset(50.0)
            $0.bottom.equalToSuperview().inset(bottomSpacing * 2.6)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(120.0)
        }
        
        buttonStackView.snp.makeConstraints {
            //$0.top.equalTo(animationView.snp.bottom).offset(50.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(50.0)
            $0.bottom.equalToSuperview().inset(bottomSpacing * 1.5)
        }
    }
    
    func setup(randomIndex: [Int]) {
        explainLabel.text = "빈 칸에 알맞은 단어를 순서대로 선택해 주세요."
        infoLabel.text = verse_info
        
        let attributedStr = NSMutableAttributedString(string: verse)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 15.0
        attributedStr.addAttribute(.paragraphStyle,
                                             value: style,
                                             range: NSRange(location: 0, length: attributedStr.length))
        
        let arrQuote: [String] = verse.components(separatedBy: " ")
        var arrRandomVerse: [String] = [ ]
       // print(randomIndex)
        
        var i = 0
        var randomString: String = "" //완전한 구절 문자열
        var randomVerse: String = "" //답안 낱말 문자열
        var suffledVerse: [String] = [ ] //답안 낱말 섞음 배열
        
        while i < arrQuote.count {
            randomString.append(" " + arrQuote[i])
            
            for j in 0...randomIndex.count - 1 {
                    if i == randomIndex[j] {
                        //print(arrQuote[i]) 답안 낱말 디버그용
                        
                        randomVerse.append(arrQuote[i] + " ") // 답안 낱말 문자열
                        arrRandomVerse.append(arrQuote[i])
                   
                        attributedStr.addAttribute(.backgroundColor, value: UIColor.systemGray, range: (verse as NSString).range(of: arrQuote[i]))
                }
            }
            
            if i == arrQuote.count {
                break
            }
            
            i += 1
        }
    
        setVerse1 = arrRandomVerse[0]
        setVerse2 = arrRandomVerse[1]
        setVerse3 = arrRandomVerse[2]
        
        suffledVerse = arrRandomVerse.shuffled() //마스킹 낱말 배열 순서 섞기
        randomVerseButton1.setTitle(suffledVerse[0], for: .normal)
        randomVerseButton2.setTitle(suffledVerse[1], for: .normal)
        randomVerseButton3.setTitle(suffledVerse[2], for: .normal)
        
        randomLabel.attributedText = attributedStr
    }
}

extension PuzzleDetailViewController {
    @objc func setRandomLabelText1() {
        if checkText(randomVerseButton1.titleLabel?.text) {
            randomVerseButton1.setTitleColor(.TitleBrown, for: .normal)
        }
    }
    
    @objc func setRandomLabelText2() {
        if checkText(randomVerseButton2.titleLabel?.text) {
            randomVerseButton2.setTitleColor(.TitleBrown, for: .normal)
        }
    }
    
    @objc func setRandomLabelText3() {
        if checkText(randomVerseButton3.titleLabel?.text) {
            randomVerseButton3.setTitleColor(.TitleBrown, for: .normal)
        }
    }
    
    @objc func moveToPuzzleViewController() {
        let puzzleViewController = PuzzleViewController()
        navigationController?.pushViewController(puzzleViewController, animated: true)
    }
    
    private func checkText(_ buttonText: String?) -> Bool {
        guard let buttonText = buttonText else { return false }
        
        if !doneVerse1 {
            if setVerse1 == buttonText {
                doneVerse1 = true
                randomLabel.asColor(targetString: setVerse1, keepString1: setVerse2, keepString2: setVerse3)
                view.makeToast("짝짝짝! 정답이에요.", duration: 1.5)
                                
                checkDone()
                
                return true
            } else {
                view.makeToast("앗! 첫번째에 들어갈 낱말과 다른 낱말이에요.", duration: 1.5)
                
                return false
            }
        } else if !doneVerse2 {
            if setVerse2 == buttonText {
                doneVerse2 = true
                randomLabel.asColor(targetString: setVerse2, keepString1: "", keepString2: setVerse3)
                view.makeToast("짝짝짝! 정답이에요.", duration: 1.5)
                
                checkDone()
                
                return true
            } else {
                view.makeToast("앗! 두번째에 들어갈 낱말과 다른 낱말이에요.", duration: 1.5)
                
                return false
            }
        } else if !doneVerse3 {
            if setVerse3 == buttonText {
                doneVerse3 = true
                randomLabel.asColor(targetString: setVerse3, keepString1: "", keepString2: "")
                view.makeToast("짝짝짝! 정답이에요.", duration: 1.5)
                
                checkDone()
                
                return true
            } else {
                view.makeToast("앗! 세번째에 들어갈 낲말과 다른 낱말이에요.", duration: 1.5)
                
                return false
            }
        }
        
        return false
    }
    
    private func checkDone() {
        if doneVerse1, doneVerse2, doneVerse3 {
            animationView.isHidden = false
            
            //3초후 view 이동
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToPuzzleViewController), userInfo: nil, repeats: false)
        }
    }
}

extension UILabel {
    func asColor(targetString: String, keepString1: String, keepString2: String) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)

        attributedString.addAttribute(.backgroundColor, value: UIColor.white, range: range)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString.addAttribute(.underlineColor, value: UIColor.TitleBrown ?? .systemBackground, range: range)
        
        if !keepString1.isEmpty {
        let keepRange1 = (fullText as NSString).range(of: keepString1)
        attributedString.addAttribute(.backgroundColor, value: UIColor.systemGray, range: keepRange1)
        }
        
        if !keepString2.isEmpty {
        let keepRange2 = (fullText as NSString).range(of: keepString2)
        attributedString.addAttribute(.backgroundColor, value: UIColor.systemGray, range: keepRange2)
        }
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 15.0
        attributedString.addAttribute(.paragraphStyle,
                                             value: style,
                                             range: NSRange(location: 0, length: attributedString.length))
        
        attributedText = attributedString
    }
}
