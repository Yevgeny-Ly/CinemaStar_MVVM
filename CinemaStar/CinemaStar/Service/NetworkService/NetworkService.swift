// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сетевого сервиса
protocol NetworkServiceProtocol {
    /// Получение всех фильмов
    func getFilms(withCompletion completionHandler: @escaping ([FilmsDTO]?) -> ())
    /// Получение деталей фильма
    func getDetailsFilm(id: Int, withCompletion completionHandler: @escaping (DetailsFilmDTO?) -> ())
}

/// Протокол сетевого запроса
protocol NetworkRequest: AnyObject {
    /// Преобразование данных в тип модели для фильмов
    associatedtype ModelFilms
    /// Преобразование данных в тип модели для деталей фильма
    associatedtype ModelFilmDetails
    /// Асинхронная передача данных фильмов
    func decodeFilms(_ data: Data) -> [ModelFilms]?
    /// Асинхронная передача данных деталей фильма
    func decodeDetailsFilm(_ data: Data) -> ModelFilmDetails?
}

/// Сервис  для работы с сетевыми запросами
final class NetworkService {
    typealias ModelFilms = FilmsDTO
    typealias ModelFilmDetails = DetailsFilmDTO
    let components = Components()
}

// MARK: - Extension + NetworkRequest

extension NetworkService: NetworkRequest {
    func decodeFilms(_ data: Data) -> [FilmsDTO]? {
        let decodeModel = try? JSONDecoder().decode(Films.self, from: data)
        let result = decodeModel?.docs.map { FilmsDTO(dto: $0) }
        return result
    }

    func decodeDetailsFilm(_ data: Data) -> DetailsFilmDTO? {
        let decodeModel = try? JSONDecoder().decode(DetailsFilm.self, from: data)
        if let decodeModel = decodeModel {
            let result = DetailsFilmDTO(dto: decodeModel)
            return result
        } else {
            return nil
        }
    }
}

// MARK: - Extension + NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    func getFilms(withCompletion completionHandler: @escaping ([FilmsDTO]?) -> ()) {
        loadFilms(components.createURLComponents(), withCompletion: completionHandler)
    }

    func getDetailsFilm(id: Int, withCompletion completionHandler: @escaping (DetailsFilmDTO?) -> ()) {
        loadDetailsFilms(components.createDetailsURLComponents(id: id), withCompletion: completionHandler)
    }
}

// MARK: - Extension + NetworkRequest

private extension NetworkRequest {
    func loadFilms(_ url: URLRequest?, withCompletion completion: @escaping ([ModelFilms]?) -> ()) {
        guard let url else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data,
                  let value = self?.decodeFilms(data)
            else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }

    func loadDetailsFilms(_ url: URLRequest?, withCompletion completion: @escaping (ModelFilmDetails?) -> ()) {
        guard let url else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data,
                  let value = self?.decodeDetailsFilm(data)
            else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
}
