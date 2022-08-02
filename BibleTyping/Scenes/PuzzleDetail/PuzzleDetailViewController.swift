//
//  PuzzleDetailViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/02.
//

import UIKit
import SnapKit

final class PuzzleDetailViewController: UIViewController {
    private lazy var presenter = PuzzleDetailPresenter(viewController: self, quote: verse)
    private var verse: String = ""
    private var verse_info: String = ""
    
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
        [explainLabel, infoLabel, randomLabel]
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
            $0.leading.equalTo(infoLabel.snp.leading)
            $0.trailing.equalTo(infoLabel.snp.trailing)
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
        print(randomIndex)
        
        var i = 0
        var randomString: String = ""
        
        while i < arrQuote.count {
            randomString.append(" " + arrQuote[i])
            
            for j in 0...randomIndex.count - 1 {
                    if i == randomIndex[j] {
                        print(arrQuote[i])
                        
                        attributedStr.addAttribute(.backgroundColor, value: UIColor.systemGray, range: (verse as NSString).range(of: arrQuote[i]))
                }
            }
            
            if i == arrQuote.count {
                break
            }
            
            i += 1
        }
        
        randomLabel.attributedText = attributedStr
        //randomLabel.setLineSpacing(spacing: 30.0)
    }
}
