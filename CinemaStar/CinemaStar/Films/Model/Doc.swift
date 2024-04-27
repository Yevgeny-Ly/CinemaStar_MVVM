// Doc.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель полей к фильму
struct Doc: Codable {
    /// Название фильма
    let name: String
    /// Название постера
    let poster: Backdrop
    /// Рейтинг фильма
    let rating: Rating
    /// Индификатор фильма
    let id: Int
}
