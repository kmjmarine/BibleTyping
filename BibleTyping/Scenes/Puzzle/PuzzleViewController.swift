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
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        
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
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}


extension PuzzleViewController: PuzzleProtocol {
    func setupViews() {
        [quoteLabel]
            .forEach{ view.addSubview($0) }
        
        quoteLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
    }
    
    func setup(verse: String, verse_info: String) {
        quoteLabel.text = verse + verse_info
    }
}
