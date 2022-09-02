//
//  BookmarkListViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/30.
//

import UIKit
import SnapKit
import Lottie

final class BookmarkListViewController: UIViewController {
    private var bookmark: [Bookmark] = []
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .regular)
        label.textAlignment = .center
        label.text = "북마크가 설정된 구절이 없어요."
        
        return label
    }()
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "empty")
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        
        return animationView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let inset: CGFloat = 16.0
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: view.frame.width - (inset * 2), height: 100.0) //최소사이즈 설정
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = inset
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(BookmarkCollectionViewCell.self, forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "북마크"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        animationView.isHidden = true
        collectionView.isHidden = true
        
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bookmark = userDefaultsManager.getBookmark()
        
        if bookmark.count <= 0 {
            animationView.isHidden = false
            collectionView.isHidden = true
        } else {
            animationView.isHidden = true
            collectionView.isHidden = false
        }
        
        collectionView.reloadData()
    }
    
    init(
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultManager()
    ) {
        self.userDefaultsManager = userDefaultsManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookmarkListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookmark.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCollectionViewCell.identifier, for: indexPath) as? BookmarkCollectionViewCell
        
        let bookmark = bookmark[indexPath.item]
        cell?.setup(from: bookmark)
        
        return cell ?? UICollectionViewCell()
    }
}

private extension BookmarkListViewController {
    func setLayout() {
        [explainLabel, animationView, collectionView]
            .forEach { view.addSubview($0) }
        
        let width = UIScreen.main.bounds.width
        
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(30.0)
        }
        
        animationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(32.0)
            $0.width.equalTo(width / 1.3)
            $0.height.equalTo(animationView.snp.width)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
