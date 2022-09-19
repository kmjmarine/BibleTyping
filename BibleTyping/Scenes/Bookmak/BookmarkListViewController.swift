//
//  BookmarkListViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/30.
//

import UIKit
import SnapKit
import Lottie
import Toast

final class BookmarkListViewController: UIViewController {
    private lazy var presenter = BookmarkListPresenter(viewController: self)
    
    private lazy var refreshContol: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        button.addTarget(self, action: #selector(didTabSort), for: .touchUpInside)
        
        return button
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
            
        let rightBarButtonItem = sortButton
        rightBarButtonItem.bounds = CGRect(x: 0, y: self.view.frame.width, width: 30, height: 30)
        navigationController?.navigationBar.addSubview(rightBarButtonItem)
        
        let targetView = self.navigationController?.navigationBar
        let trailingContraint = NSLayoutConstraint(item: rightBarButtonItem, attribute:
                .trailingMargin, relatedBy: .equal, toItem: targetView,
                                 attribute: .trailingMargin, multiplier: 1.0, constant: -16)
        let bottomConstraint = NSLayoutConstraint(item: rightBarButtonItem, attribute: .bottom, relatedBy: .equal,
                                            toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -16)
        rightBarButtonItem.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
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
    
    func alertCopy() {
        view.makeToast("copy".localized, duration: 1.5)
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
    
    @objc func didTabSort() {
        if presenter.getBookmarkCount() <= 0 {
            view.makeToast("NoBookmark".localized, duration: 1.5)
        } else {
            let alertController = UIAlertController(title: "BookmarkAlertTitle".localized, message: nil, preferredStyle: .actionSheet)
            
            //시간순
            let timeAction = UIAlertAction(title: "TimeSort".localized, style: .default) { [weak self] _ in
                self!.presenter.sortBookmark(mode: "time")
            }
            alertController.addAction(timeAction)
            timeAction.setValue(UIColor.blue, forKey: "titleTextColor")
            
            //성경순
            let nameAction = UIAlertAction(title: "NameSort".localized, style: .default) { [weak self] _ in
                self!.presenter.sortBookmark(mode: "name")
            }
            alertController.addAction(nameAction)
            nameAction.setValue(UIColor.blue, forKey: "titleTextColor")
            
            //취소
            let cancelAction = UIAlertAction(
                title: "Cancel".localized,
                style: .cancel,
                handler: nil
            )
            alertController.addAction(cancelAction)
            cancelAction.setValue(UIColor.blue, forKey: "titleTextColor")
            
            if UIDevice.current.userInterfaceIdiom == .pad { //디바이스 타입이 iPad일때
              if let popoverController = alertController.popoverPresentationController {
                  // ActionSheet가 표현되는 위치를 저장해줍니다.
                  popoverController.sourceView = self.view
                  popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
                  popoverController.permittedArrowDirections = []
                  self.present(alertController, animated: true, completion: nil)
              }
            } else {
              self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
