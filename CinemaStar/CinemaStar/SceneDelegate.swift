// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import KeychainSwift
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureSceneDelegate(windowScene: windowScene)
    }

    private func configureSceneDelegate(windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)

        let networkService = NetworkService()
        let builder = AppBulder(networkService: networkService)

        window?.makeKeyAndVisible()
        applicationCoordinator = ApplicationCoordinator(appBuilder: builder, networkService: networkService)
        applicationCoordinator?.start()
    }
}
