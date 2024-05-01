// SimilarMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель рекомендаций фильмов
struct SimilarMovie: Codable {
    /// Название
    let name: String
    /// Постер
    let poster: Backdrop
}
