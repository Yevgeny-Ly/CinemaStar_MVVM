// FilmsDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель фильмов
final class FilmsDTO {
    /// Картинка фильма
    let poster: String?
    /// Имя фильма
    let name: String
    /// Рейтинг фильма
    let rating: Double
    /// Индивидуальный номер фильма
    let id: Int

    init(dto: Doc) {
        poster = dto.poster.url
        name = dto.name
        rating = round(dto.rating.kp * 10) / 10
        id = dto.id
    }
}
