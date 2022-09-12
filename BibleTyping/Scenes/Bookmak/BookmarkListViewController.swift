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
    private lazy var presenter = BookmarkListPresenter(viewController: self)
    
    private lazy var refreshContol: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .regular)
        label.textAlignment = .center
        label.text = "NoBookmark".localized
        
        return label
    }()
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "empty")
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        
        return animationView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        tableView.register(BookmarkListTableViewCell.self, forCellReuseIdentifier: BookmarkListTableViewCell.identifier)
        
        tableView.refreshControl = refreshContol
        
        return tableView
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

extension BookmarkListViewController: BookmarkProtocol {
    func setupNavigationBar() {
        title = "Bookmark".localized
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupInitailView() {
        animationView.isHidden = true
        tableView.isHidden = true
    }
    
    func setupDoneView(bookmarks: [Bookmark]) {
        if bookmarks.count <= 0 {
            animationView.isHidden = false
            tableView.isHidden = true
        } else {
            animationView.isHidden = true
            tableView.isHidden = false
        }
    }

    func setLayout() {
        [explainLabel, animationView, tableView]
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
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func endRefreshing() {
        refreshContol.endRefreshing()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

private extension BookmarkListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
}
