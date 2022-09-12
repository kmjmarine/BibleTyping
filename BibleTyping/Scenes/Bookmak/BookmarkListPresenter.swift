//
//  BookmarkListPresenter.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/09/13.
//

import Foundation
import UIKit

protocol BookmarkProtocol: AnyObject {
    func setupNavigationBar()
    func setupInitailView()
    func setLayout()
    func setupDoneView(bookmarks: [Bookmark])
    func endRefreshing()
    func reloadTableView()
}

final class BookmarkListPresenter: NSObject {
    private weak var viewController: BookmarkProtocol?
    private let userDefaultsManager:  UserDefaultsManagerProtocol
    var bookmark: [Bookmark] = []
    
    init(viewController: BookmarkProtocol, userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupInitailView()
        viewController?.setLayout()
    }
    
    func viewWillAppear() {
        bookmark = userDefaultsManager.getBookmark()
        viewController?.reloadTableView()
        viewController?.setupDoneView(bookmarks: bookmark)
    }
    
    func didCalledRefresh() {
        requestBookmarkList()
    }
}

extension BookmarkListPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkListTableViewCell.identifier, for: indexPath) as? BookmarkListTableViewCell
        
        let bookmarks = bookmark[indexPath.row]
        cell?.setup(from: bookmarks)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmark.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completion) in
            let bookmarks = self!.bookmark[indexPath.row]
            self!.userDefaultsManager.delBookmark(bookmarks)
            self!.bookmark.remove(at: indexPath.row)
            self!.viewController?.setupDoneView(bookmarks: self!.bookmark)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        action.backgroundColor = .red
        action.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

private extension BookmarkListPresenter {
    func requestBookmarkList() {
        bookmark = []
        
        bookmark = userDefaultsManager.getBookmark()
        viewController?.setupDoneView(bookmarks: bookmark)
        viewController?.reloadTableView()
        viewController?.endRefreshing()
    }
}
