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
    
    private lazy var bibleSwitch: UISwitch = {
        let mySwitch = UISwitch(frame: CGRect.zero)
        mySwitch.isOn = false
        mySwitch.onTintColor = .systemGray4
        mySwitch.tintColor = .red
        mySwitch.thumbTintColor = .TitleBrown
        mySwitch.layer.cornerRadius = mySwitch.frame.height / 2.0
        mySwitch.backgroundColor = .systemGray4
        mySwitch.clipsToBounds = true
        mySwitch.addTarget(self, action: #selector(switchTab), for:  .valueChanged)
        
        return mySwitch
    }()
    
    private lazy var bibleKindLabel: UILabel = {
        let label = UILabel()
        label.text = "구약성경"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .TitleBrown
        label.clipsToBounds = true
        label.layer.cornerRadius = 10.0
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        
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
        
        //navigationbar back button 숨김
        self.navigationItem.hidesBackButton = true
        
        if (bibleSwitch.isOn == true) {
            bibleKindLabel.text = "신약성경"
            oldBibleCollectionView.isHidden = true
            newBibleCollectionView.isHidden = false
        } else {
            bibleKindLabel.text = "구약성경"
            newBibleCollectionView.isHidden = true
            oldBibleCollectionView.isHidden = false
        }
        
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        self.oldBibleCollectionView.reloadData()
        self.newBibleCollectionView.reloadData()
                                                   
        let rightBarButtonItem1 = bibleSwitch
        rightBarButtonItem1.bounds = CGRect(x: 0, y: 0, width: 50, height: 30)
        let rightItem1 = UIBarButtonItem(customView: rightBarButtonItem1)
       
        let rightBarButtonItem2 = bibleKindLabel
        rightBarButtonItem2.bounds = CGRect(x: 0, y: 0, width: 70, height: 30)
        let rightItem2 = UIBarButtonItem(customView: rightBarButtonItem2)
        
        self.navigationItem.setRightBarButtonItems([rightItem2, rightItem1], animated: true)

        presenter.viewWillAppear()
    }
}

extension TypingListViewController: TypingListProtocol {
    func setupView() {
        [oldBibleCollectionView, newBibleCollectionView]
            .forEach { view.addSubview($0) }
        
        let inset: CGFloat = 16.0
    
        oldBibleCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
        }
        
        newBibleCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
        }
    }
    
    func pushToTypingViewController(book: String, kind: String) {
        let typingDetailViewController = TypingDetailViewController(book: book, kind: kind, chapter: 1, verse: 1)
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
    
    @objc func switchTab(sender: UISwitch) {
        if (sender.isOn == true) {
            sender.setOn(true, animated: true)
            bibleKindLabel.text = "신약성경"
            oldBibleCollectionView.isHidden = true
            newBibleCollectionView.isHidden = false
        } else {
            sender.setOn(false, animated: true)
            bibleKindLabel.text = "구약성경"
            newBibleCollectionView.isHidden = true
            oldBibleCollectionView.isHidden = false
        }
    }
}

