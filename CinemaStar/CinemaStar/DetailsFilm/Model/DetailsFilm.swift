// DetailsFilm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель деталей фильма
struct DetailsFilm: Codable {
    /// Рекомендации
    let similarMovies: [SimilarMovie]?
    /// Язык
    let spokenLanguages: [SpokenLanguage]?
    /// Актеры
    let persons: [Person]?
    /// Постер
    let poster: Backdrop?
    /// Страна производитель
    let countries: [Country]?
    /// Рейтинг фильма
    let rating: Rating
    /// Год
    let year: Int
    /// Название
    let name: String
    /// Описание
    let description: String
    /// Тип
    let type: String
    /// Идентификатор
    let id: Int
}
