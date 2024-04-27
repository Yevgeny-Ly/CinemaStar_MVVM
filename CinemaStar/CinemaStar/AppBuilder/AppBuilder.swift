// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Контейнер зависимостей и сборка модулей
final class AppBulder {
    // MARK: - Private Properties

    private let networkService: NetworkService

    // MARK: - Initializers

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func makeFilmsViewController(filmsCoordinator: FilmsCoordinator) -> FilmsController {
        let viewModel = FilmsViewModel(coordinator: filmsCoordinator, networkService: networkService)
        let view = FilmsController(viewModel: viewModel)
        return view
    }
}
