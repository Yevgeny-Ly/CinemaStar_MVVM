// DetailsFilmViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для вью модели экрана с деталями фильма
protocol DetailsFilmViewModelProtocol {
    /// Получение деталей фильма из сети
    func fetchRequestDetailsFilm()
    /// Обновляет состояние Вью
    var updateViewHandler: ((StateViewDetails) -> ())? { get set }
    /// ДТО детального экрана
    var detailsFilmDTO: DetailsFilmDTO? { get set }
    /// Сервисный слой
    var favoritesService: FavoritesService { get set }
}

// Модель для детального экрана фильма
final class DetailsFilmViewModel {
    // MARK: - Public Properties

    var updateViewHandler: ((StateViewDetails) -> ())?
    var detailsFilmDTO: DetailsFilmDTO?
    var favoritesService = FavoritesService()

    // MARK: - Private Properties

    private var id: Int
    private var networkService: NetworkServiceProtocol

    // MARK: - Initializers

    init(networkService: NetworkServiceProtocol, id: Int) {
        updateViewHandler?(.initial)
        self.networkService = networkService
        self.id = id
    }
}

// MARK: - Extension + DetailsFilmViewModelProtocol

extension DetailsFilmViewModel: DetailsFilmViewModelProtocol {
    func fetchRequestDetailsFilm() {
        updateViewHandler?(.loading)
        networkService.getDetailsFilm(id: id) { [weak self] result in
            guard let self else { return }
            guard let result else { return }
            DispatchQueue.main.async {
                self.updateViewHandler?(.success(result))
            }
        }
    }
}
