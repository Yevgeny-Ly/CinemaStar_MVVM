// DetailsFilmDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель деталей фильмов
final class DetailsFilmDTO {
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
    /// Рейтинг
    let rating: Double
    /// Год выпуска
    let year: Int?
    /// Название
    let name: String?
    /// Описание
    let description: String?
    /// Тип
    let type: String?
    /// Идентификатор
    let id: Int?

    init(dto: DetailsFilm) {
        similarMovies = dto.similarMovies
        spokenLanguages = dto.spokenLanguages
        persons = dto.persons
        poster = dto.poster
        countries = dto.countries
        rating = round(dto.rating.kp * 10) / 10
        year = dto.year
        name = dto.name
        description = dto.description
        type = dto.type
        id = dto.id
    }
}
