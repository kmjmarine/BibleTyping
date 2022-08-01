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
    private var timeLeft = 5
    
    private lazy var quoteBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12.0
        
        return view
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 30.0, weight: .black)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = .systemFont(ofSize: 60.0, weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemBlue
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "퍼즐맞추기"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemYellow
        appearance.titleTextAttributes = [.foregroundColor: UIColor.TitleBrown ?? .systemBackground]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.TitleBrown ?? .systemBackground]

        navigationController?.navigationBar.tintColor = UIColor.TitleBrown
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(pushToPuzzleWriteViewController), userInfo: nil, repeats: true)
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}

extension PuzzleViewController: PuzzleProtocol {
    func setupViews() {
        [quoteBaseView, quoteLabel, timerLabel]
            .forEach{ view.addSubview($0) }
        
        quoteBaseView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(200.0)
            //$0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0.0)
        }
        
        quoteLabel.snp.makeConstraints {
            $0.leading.equalTo(quoteBaseView.snp.leading).inset(24.0)
            $0.trailing.equalTo(quoteBaseView.snp.trailing).inset(24.0)
            $0.top.equalTo(quoteBaseView.snp.top).inset(24.0)
        }
        
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(quoteBaseView.snp.bottom).offset(32.0)
            $0.leading.equalTo(quoteLabel.snp.leading)
            $0.trailing.equalTo(quoteLabel.snp.trailing)
        }
    }
    
    func setup(verse: String, verse_info: String) {
        quoteLabel.text = verse + verse_info
    }
}

extension PuzzleViewController {
    @objc func pushToPuzzleWriteViewController() {
        timerLabel.text = String(timeLeft)
        timeLeft = timeLeft - 1
        
        if timeLeft <= -1 {
            timer?.invalidate()
            timer = nil
            
            let puzzleDetailViewViewController = PuzzleDetailViewController(verse: quoteLabel.text!)
            navigationController?.pushViewController(puzzleDetailViewViewController, animated: true)
        }
    }
}
