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
        
        let TypingController = UINavigationController(rootViewController: TypingListViewController())
        TypingController.tabBarItem = UITabBarItem(title: "성경타자", image: UIImage(systemName: "keyboard"), selectedImage: UIImage(systemName: "keyboard.fill"))
        let PuzzleController = UINavigationController(rootViewController: PuzzleViewController())
        PuzzleController.tabBarItem = UITabBarItem(title: "구절맞추기", image: UIImage(systemName: "puzzlepiece.extension"), selectedImage: UIImage(systemName: "puzzlepiece.extension.fill"))
        
        viewControllers = [TypingController, PuzzleController]
    }
}
