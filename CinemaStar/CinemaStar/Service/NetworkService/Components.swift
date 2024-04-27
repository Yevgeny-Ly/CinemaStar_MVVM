// Components.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainSwift

/// Компоненты и элементы для URL запросов
final class Components {
    // MARK: - Constants

    private enum Constants {
        static let scheme = "https"
        static let host = "api.kinopoisk.dev"
        static let path = "/v1.4/movie/search"
        static let query = "query"
        static let apiKey = "X-API-KEY"
    }

    // MARK: - Private Properties

    private var key = KeychainSwift()
    lazy var value = key.get("key")
    private var id: Int?
    private var component = URLComponents()
    private let scheme = Constants.scheme
    private let host = Constants.host
    private let path = Constants.path

    // MARK: - Initializers

    convenience init(id: Int) {
        self.init()
        self.id = id
    }

    // MARK: - Public Methods

    func createURLQueryItems(query: String) -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: Constants.query, value: query)
        ]
        return queryItems
    }

    func createURLComponents() -> URLRequest? {
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = createURLQueryItems(query: "история")
        let url = component.url ?? URL(fileURLWithPath: "")
        var request = URLRequest(url: url)
        request.setValue(value, forHTTPHeaderField: Constants.apiKey)
        return request
    }

    func createDetailsURLComponents(id: Int) -> URLRequest? {
        component.scheme = scheme
        component.host = host
        component.path = "/v1.4/movie/\(id)"
        let url = component.url ?? URL(fileURLWithPath: "")
        var request = URLRequest(url: url)
        request.setValue(value, forHTTPHeaderField: Constants.apiKey)
        return request
    }
}
