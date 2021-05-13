//
//  SceneDelegate.swift
//  Films
//
//  Created by iOS_Coder on 04.03.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)

        let navController = UINavigationController()
        let moduleBuilder = ModuleBuilder()
        let coordinator = MovieListCoordinator(navigationController: navController, moduleBuilder: moduleBuilder)
        coordinator.start()

        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        CoreDataStack.shared.saveToStore()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        CoreDataStack.shared.saveToStore()
    }
}
