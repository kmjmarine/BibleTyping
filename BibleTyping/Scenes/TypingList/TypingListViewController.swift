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
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
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
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
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
        
        oldBibleCollectionView.tag = 1
        newBibleCollectionView.tag = 2
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}

extension TypingListViewController: TypingListProtocol {
    func setupView() {
        [oldBibleLabel, oldBibleCollectionView, newBibleLabel, newBibleCollectionView]
            .forEach { view.addSubview($0) }
        
        let inset: CGFloat = 16.0
        
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
            $0.height.equalTo(300.0)
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
            $0.height.equalTo(300.0)
        }
    }
    
    func pushToTypingViewController(kindBible: Int) {
        let typingDetailViewController = TypingDetailViewController(kindBible: kindBible)
        navigationController?.pushViewController(typingDetailViewController, animated: true)
    }
}
