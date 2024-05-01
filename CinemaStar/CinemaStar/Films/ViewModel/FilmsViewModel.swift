// FilmsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для вью модели экрана с фильмами
protocol FilmsViewModelProtocol {
    /// Переход на экран деталей фильма
    func showDetailsFilmViewController(id: Int)
    /// Получить фильмы из сети
    func fetchRequestFilms()
    /// Обновляет состояние Вью
    var updateViewHandler: ((StateView) -> ())? { get set }
}

/// Вью модель экрана с фильмами
final class FilmsViewModel {
    // MARK: - Public Properties

    public var updateViewHandler: ((StateView) -> ())?

    // MARK: - Private Properties

    private weak var coordinator: FilmsCoordinator?
    private weak var networkService: NetworkService?

    // MARK: - Initializers

    init(coordinator: FilmsCoordinator?, networkService: NetworkService?) {
        self.coordinator = coordinator
        self.networkService = networkService
        updateViewHandler?(.initial)
    }
}

// MARK: - Extension + FilmsViewModelProtocol

extension FilmsViewModel: FilmsViewModelProtocol {
    func showDetailsFilmViewController(id: Int) {
        coordinator?.pushDetailsFilmController(id: id)
    }

    func fetchRequestFilms() {
        updateViewHandler?(.loading)
        networkService?.getFilms(withCompletion: { [weak self] result in
            guard let self else { return }
            guard let result else { return }
            DispatchQueue.main.async {
                self.updateViewHandler?(.success(result))
            }
        })
    }
}
