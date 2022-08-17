//
//  TypingListViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/09.
//

import UIKit
import SnapKit

final class TypingListViewController: UIViewController {
    private lazy var presenter = TypingListPresenter(viewController: self)
    
    private lazy var oldBibleLabel: UILabel = {
        let label = UILabel()
        label.text = "구약성경"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        
        return label
    }()
    
    private lazy var oldBibleCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        
        collectionView.register(TypingListCollectionViewCell.self, forCellWithReuseIdentifier: TypingListCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private lazy var newBibleLabel: UILabel = {
        let label = UILabel()
        label.text = "신약성경"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        
        return label
    }()
    
    private lazy var newBibleCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        
        collectionView.register(TypingListCollectionViewCell.self, forCellWithReuseIdentifier: TypingListCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "성경통독"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemYellow
        appearance.titleTextAttributes = [.foregroundColor: UIColor.TitleBrown ?? .systemBackground]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.TitleBrown ?? .systemBackground]

        navigationController?.navigationBar.tintColor = UIColor.TitleBrown
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        oldBibleCollectionView.tag = 1
        newBibleCollectionView.tag = 2
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        self.oldBibleCollectionView.reloadData()
        self.newBibleCollectionView.reloadData()
        
        presenter.viewWillAppear()
    }
}

extension TypingListViewController: TypingListProtocol {
    func setupView() {
        [oldBibleLabel, oldBibleCollectionView, newBibleLabel, newBibleCollectionView]
            .forEach { view.addSubview($0) }
        
        let inset: CGFloat = 16.0
        let bottomSpacing: CGFloat = (tabBarController?.tabBar.frame.height)!
        
        oldBibleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(32.0)
        }
        
        oldBibleCollectionView.snp.makeConstraints {
            $0.top.equalTo(oldBibleLabel.snp.bottom)
            $0.leading.equalTo(oldBibleLabel.snp.leading)
            $0.trailing.equalTo(oldBibleLabel.snp.trailing)
            $0.height.equalTo(270.0)
        }
        
        newBibleLabel.snp.makeConstraints {
            $0.top.equalTo(oldBibleCollectionView.snp.bottom).offset(32.0)
            $0.leading.equalTo(oldBibleCollectionView.snp.leading)
            $0.trailing.equalTo(oldBibleCollectionView.snp.trailing)
            $0.height.equalTo(32.0)
        }
        
        newBibleCollectionView.snp.makeConstraints {
            $0.top.equalTo(newBibleLabel.snp.bottom)
            $0.leading.equalTo(newBibleLabel.snp.leading)
            $0.trailing.equalTo(newBibleLabel.snp.trailing)
            $0.height.equalTo(270.0)
            $0.bottom.equalToSuperview().inset(bottomSpacing * 1.3)
        }
    }
    
    func pushToTypingViewController(book: String, kind: String) {
        let typingDetailViewController = TypingDetailViewController(book: book, kind: kind, chpater: 1, verse: 1)
        navigationController?.pushViewController(typingDetailViewController, animated: false)
    }
    
    func showCloseAlertController() {
        let alertController = UIAlertController(title: "데이터 읽기에 실패 했습니다.\n잠시 후에 다시 시도해 주세요.", message: nil, preferredStyle: .alert)
      
        let closeAction = UIAlertAction(title: "닫기", style: .destructive) {[weak self] _ in
            self?.dismiss(animated: true)
        }
        
        [closeAction].forEach { action in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
}

