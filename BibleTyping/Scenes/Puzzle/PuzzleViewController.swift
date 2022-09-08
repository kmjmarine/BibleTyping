//
//  PuzzleViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/26.
//

import UIKit
import SnapKit

final class PuzzleViewController: UIViewController {
    private lazy var presenter = PuzzlePresenter(viewController: self)
    private var timer: Timer?
    private var timeLeft: Int = 5
    private var progressTime: Float = 0.0
    private var verse: String = ""
    private var verse_info: String = ""
    
    private lazy var quoteBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12.0
        
        return view
    }()
    
    private lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .regular)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 25.0, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = .systemFont(ofSize: 100.0, weight: .bold)
        label.textAlignment = .center
        label.textColor = .TitleBrown
        
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = .lightGray
        progressView.progressTintColor = .TitleBrown
        progressView.progress = 0.0
        progressView.layer.cornerRadius = 6
        progressView.clipsToBounds = true
        
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quiz".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pushToPuzzleWriteViewController), userInfo: nil, repeats: true)
        
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        timeLeft = 5
        progressTime = 0.0
    }
}

extension PuzzleViewController: PuzzleProtocol {
    func setupViews() {
        [explainLabel, quoteBaseView, quoteLabel, timerLabel, progressView]
            .forEach { view.addSubview($0) }
        
        let bottomSpacing: CGFloat = (tabBarController?.tabBar.frame.height)!
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        quoteBaseView.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(bottomSpacing * 4.3)
        }
        
        quoteLabel.snp.makeConstraints {
            $0.top.equalTo(quoteBaseView.snp.top).inset(24.0)
            $0.leading.equalTo(quoteBaseView.snp.leading).inset(24.0)
            $0.trailing.equalTo(quoteBaseView.snp.trailing).inset(24.0)
        }
        
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(quoteBaseView.snp.bottom).offset(24.0)
            $0.leading.equalTo(quoteLabel.snp.leading)
            $0.trailing.equalTo(quoteLabel.snp.trailing)
        }

        progressView.snp.makeConstraints {
            $0.top.equalTo(timerLabel.snp.bottom).offset(16.0)
            $0.leading.equalTo(quoteBaseView.snp.leading)
            $0.trailing.equalTo(quoteBaseView.snp.trailing)
            $0.height.equalTo(10.0)
            $0.bottom.equalToSuperview().inset(bottomSpacing * 1.4)
        }
    }
    
    func setup(verse: String, verse_info: String) {
        self.verse = verse
        self.verse_info = verse_info
        
        quoteLabel.text = verse + " "  + verse_info
        explainLabel.text = "PreExplain".localized
    }
}

private extension PuzzleViewController {
    @objc func pushToPuzzleWriteViewController() {
        timerLabel.text = String(timeLeft)
        timeLeft -=  1
        
        progressView.setProgress(progressTime, animated: true)
        progressTime += 0.25
        
        if timeLeft <= -1 {
            timer?.invalidate()
            timer = nil
            
            let puzzleDetailViewViewController = PuzzleDetailViewController(verse: self.verse, verse_info: self.verse_info)
            navigationController?.pushViewController(puzzleDetailViewViewController, animated: false)
        }
    }
}
