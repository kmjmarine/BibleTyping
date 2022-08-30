//
//  BookmarkListViewController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/08/30.
//

import Foundation
import UIKit

final class BookmarkListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "북마크"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemYellow
        appearance.titleTextAttributes = [.foregroundColor: UIColor.TitleBrown ?? .systemBackground]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.TitleBrown ?? .systemBackground]

        navigationController?.navigationBar.tintColor = UIColor.TitleBrown
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
