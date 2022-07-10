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
    
    private lazy var collectionView: UICollectionView = {
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
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}

extension TypingListViewController: TypingListProtocol {
    func setupView() {
        [oldBibleLabel, collectionView]
            .forEach { view.addSubview($0) }
        
        let inset: CGFloat = 16.0
        
        oldBibleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(32.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(oldBibleLabel.snp.bottom)
            $0.leading.equalTo(oldBibleLabel.snp.leading)
            $0.trailing.equalTo(oldBibleLabel.snp.trailing)
            $0.height.equalTo(700.0)

        }
    }
    
    func pushToTypingViewController() {
        let typingDetailViewController = TypingDetailViewController()
        navigationController?.pushViewController(typingDetailViewController, animated: true)
    }
}
