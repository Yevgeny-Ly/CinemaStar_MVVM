// FilmsCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор экрана с фильмами
final class FilmsCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootViewController: UINavigationController?

    // MARK: - Private Properties

    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func setRootController(viewController: UINavigationController) {
        rootViewController = viewController
    }

    func pushDetailsFilmController(id: Int) {
        let viewModel = DetailsFilmViewModel(networkService: networkService, id: id)
        let detailsFilmController = DetailsFilmController(viewModel: viewModel)
        rootViewController?.pushViewController(detailsFilmController, animated: true)
    }
}
