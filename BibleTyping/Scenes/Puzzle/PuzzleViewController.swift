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
        
        title = "구절맞추기"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemYellow
        appearance.titleTextAttributes = [.foregroundColor: UIColor.TitleBrown ?? .systemBackground]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.TitleBrown ?? .systemBackground]

        navigationController?.navigationBar.tintColor = UIColor.TitleBrown
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pushToPuzzleWriteViewController), userInfo: nil, repeats: true)
        
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timeLeft = 5
        progressTime = 0.0
    }
}

extension PuzzleViewController: PuzzleProtocol {
    func setupViews() {
        [quoteBaseView, quoteLabel, timerLabel, progressView]
            .forEach{ view.addSubview($0) }
        
        quoteBaseView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(250.0)
        }
        
        quoteLabel.snp.makeConstraints {
            $0.top.equalTo(quoteBaseView.snp.top).inset(24.0)
            $0.leading.equalTo(quoteBaseView.snp.leading).inset(24.0)
            $0.trailing.equalTo(quoteBaseView.snp.trailing).inset(24.0)
        }
        
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(quoteBaseView.snp.bottom).offset(80.0)
            $0.leading.equalTo(quoteLabel.snp.leading)
            $0.trailing.equalTo(quoteLabel.snp.trailing)
        }
        
        let bottomSpacing: CGFloat = (tabBarController?.tabBar.frame.height)!
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(timerLabel.snp.bottom).offset(16.0)
            $0.leading.equalTo(quoteBaseView.snp.leading)
            $0.trailing.equalTo(quoteBaseView.snp.trailing)
            $0.height.equalTo(10.0)
            $0.bottom.equalToSuperview().inset(bottomSpacing * 2.0)
        }
    }
    
    func setup(verse: String, verse_info: String) {
        self.verse = verse
        self.verse_info = verse_info
        
        quoteLabel.text = verse + " "  + verse_info
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
            navigationController?.pushViewController(puzzleDetailViewViewController, animated: true)
        }
    }
}
