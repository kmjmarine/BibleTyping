//
//  PuzzleDetailViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/02.
//

import UIKit
import SnapKit
import Toast

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
    
    private lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .regular)
        label.textAlignment = .center
        
        return label
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
        
        presenter.viewWillAppear()
    }
}

extension PuzzleDetailViewController: PuzzleDetailProtocol {
    func setupViews() {
        [explainLabel, infoLabel, randomLabel, buttonStackView]
            .forEach { view.addSubview($0) }
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(30.0)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(32.0)
            $0.leading.equalTo(explainLabel.snp.leading)
            $0.trailing.equalTo(explainLabel.snp.trailing)
        }
        
        randomLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(randomLabel.snp.bottom).offset(300.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(50.0)
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
                        print(arrQuote[i])
                        
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
        
        suffledVerse = arrRandomVerse.shuffled()
        randomVerseButton1.setTitle(suffledVerse[0], for: .normal)
        randomVerseButton2.setTitle(suffledVerse[1], for: .normal)
        randomVerseButton3.setTitle(suffledVerse[2], for: .normal)
        
        randomLabel.attributedText = attributedStr
    }
}

extension PuzzleDetailViewController {
    @objc func setRandomLabelText1() {
        if !doneVerse1 {
            if setVerse1 == randomVerseButton1.titleLabel?.text {
                doneVerse1 = true
                view.makeToast("짝짝짝! 정답이에요.")
            } else {
                view.makeToast("앗! 첫번째에 들어갈 낲말과 다른 낱말이에요.")
            }
        } else if !doneVerse2 {
            if setVerse2 == randomVerseButton1.titleLabel?.text {
                doneVerse2 = true
                view.makeToast("짝짝짝! 정답이에요.")
            } else {
                view.makeToast("앗! 두번째에 들어갈 낲말과 다른 낱말이에요.")
            }
        } else if !doneVerse3 {
            if setVerse3 == randomVerseButton1.titleLabel?.text {
                doneVerse3 = true
                view.makeToast("짝짝짝! 정답이에요.")
            } else {
                view.makeToast("앗! 세번째에 들어갈 낲말과 다른 낱말이에요.")
            }
        }
    }
    
    @objc func setRandomLabelText2() {
        if !doneVerse1 {
            if setVerse1 == randomVerseButton2.titleLabel?.text {
                doneVerse1 = true
                view.makeToast("짝짝짝! 정답이에요.")
            } else {
                view.makeToast("앗! 첫번째에 들어갈 낲말과 다른 낱말이에요.")
            }
        } else if !doneVerse2 {
            if setVerse2 == randomVerseButton2.titleLabel?.text {
                doneVerse2 = true
                view.makeToast("짝짝짝! 정답이에요.")
            } else {
                view.makeToast("앗! 두번째에 들어갈 낲말과 다른 낱말이에요.")
            }
        } else if !doneVerse3 {
            if setVerse3 == randomVerseButton2.titleLabel?.text {
                doneVerse3 = true
                view.makeToast("짝짝짝! 정답이에요.")
            } else {
                view.makeToast("앗! 세번째에 들어갈 낲말과 다른 낱말이에요.")
            }
        }
    }
    
    @objc func setRandomLabelText3() {
        if !doneVerse1 {
            if setVerse1 == randomVerseButton3.titleLabel?.text {
                doneVerse1 = true
                view.makeToast("짝짝짝! 정답이에요.")
            } else {
                view.makeToast("앗! 첫번째에 들어갈 낲말과 다른 낱말이에요.")
            }
        } else if !doneVerse2 {
            if setVerse2 == randomVerseButton3.titleLabel?.text {
                doneVerse2 = true
                view.makeToast("짝짝짝! 정답이에요.")
            } else {
                view.makeToast("앗! 두번째에 들어갈 낲말과 다른 낱말이에요.")
            }
        } else if !doneVerse3 {
            if setVerse3 == randomVerseButton3.titleLabel?.text {
                doneVerse3 = true
                view.makeToast("짝짝짝! 정답이에요.")
            } else {
                view.makeToast("앗! 세번째에 들어갈 낲말과 다른 낱말이에요.")
            }
        }
    }
}
