//
//  SceneDelegate.swift
//  BibleTyping
//
//  Created by kmjmarine on 2022/07/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        window?.backgroundColor = .systemBackground
        window?.tintColor = .systemBrown
        window?.rootViewController = UINavigationController(rootViewController: IntroViewController())
        window?.makeKeyAndVisible()
    }
}

