// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Главный координатор
final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var viewModel: DetailsFilmViewModel?
    var networkService: NetworkServiceProtocol

    // MARK: - Private Properties

    private var appBuilder: AppBulder

    // MARK: - Initializers

    init(appBuilder: AppBulder, networkService: NetworkServiceProtocol) {
        self.appBuilder = appBuilder
        self.networkService = networkService
    }

    override func start() {
        cinemaStar()
    }

    // MARK: - Private Methods

    private func cinemaStar() {
        let filmsCoordinator = FilmsCoordinator(networkService: networkService)
        let filmsModule = appBuilder.makeFilmsViewController(filmsCoordinator: filmsCoordinator)
        let rootViewController = UINavigationController(rootViewController: filmsModule)
        filmsCoordinator.setRootController(viewController: rootViewController)
        add(coordinator: filmsCoordinator)
        setAsRoot(rootViewController)
    }
}
