//
//  TabbarController.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/26.
//

import UIKit

final class TabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let IntroController = UINavigationController(rootViewController: IntroViewController())
        IntroController.tabBarItem = UITabBarItem(
            title: "Home".localized,
            image: UIImage(systemName: "house"),
            selectedImage:UIImage (systemName: "house.fill")
        )
        
        let TypingController = UINavigationController(rootViewController: TypingListViewController())
        TypingController.tabBarItem = UITabBarItem(
            title: "BibleTyping".localized,
            image: UIImage(systemName: "keyboard"),
            selectedImage: UIImage(systemName: "keyboard.fill")
        )
        
        let PuzzleController = UINavigationController(rootViewController: PuzzleViewController())
        PuzzleController.tabBarItem = UITabBarItem(
            title: "Quiz".localized,
            image: UIImage(systemName: "puzzlepiece.extension"),
            selectedImage: UIImage(systemName: "puzzlepiece.extension.fill")
        )
        
        let bookmarkViewController = UINavigationController(rootViewController: BookmarkListViewController())
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: "Bookmark".localized,
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        viewControllers = [IntroController, TypingController, PuzzleController, bookmarkViewController]
    }
}

