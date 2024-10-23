//
//  SceneDelegate.swift
//  JGDDMembership
//
//  Created by minsong kim on 10/21/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }

            // UIWindow 설정
            window = UIWindow(windowScene: windowScene)

            // 시작할 ViewController 설정
            let viewController = ViewController()
            
            // UINavigationController로 감싸기
            let navigationController = UINavigationController(rootViewController: viewController)

            // window의 rootViewController를 네비게이션 컨트롤러로 설정
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }

}
