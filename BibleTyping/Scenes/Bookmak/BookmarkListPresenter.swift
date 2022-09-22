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
    func alertCopy()
    func showAlert(indexPath: IndexPath)
}

final class BookmarkListPresenter: NSObject {
    private weak var viewController: BookmarkProtocol?
    let userDefaultsManager: UserDefaultsManagerProtocol
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
    
    func getBookmarkCount() -> Int {
        return bookmark.count
    }
    
    func sortBookmark(mode: String) {
        if mode == "time" {
            bookmark.sort { $0.date! > $1.date! }
        } else {
            bookmark.sort { $0.bookname < $1.bookname }
        }
        viewController?.reloadTableView()
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let speakAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completion) in
            let bookmarks = self!.bookmark[indexPath.row]
           
            TTSManager.shared.play(bookmarks.quote, bookmarks.language ?? "ko")
            
            completion(true)
        }
            
        speakAction.backgroundColor = .systemTeal
        speakAction.image = UIImage(systemName: "speaker.wave.3")
        
        let configuration = UISwipeActionsConfiguration(actions: [speakAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let copyAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completion) in
            let bookmarks = self!.bookmark[indexPath.row]
            var PasteBoardString: String {
                return "\(bookmarks.bookname.localized ) \(bookmarks.chapter)\("chapter".localized) \(bookmarks.verse)\("verse".localized) \n\(bookmarks.quote) "
            }
            UIPasteboard.general.string = PasteBoardString
           
            self?.viewController?.alertCopy()
            
            completion(true)
        }
        
        let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completion) in
            self?.viewController?.showAlert(indexPath: indexPath)
            completion(true)
        }
        
        copyAction.backgroundColor = .TitleBrown
        copyAction.image = UIImage(systemName: "doc.on.doc")
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, copyAction])
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
