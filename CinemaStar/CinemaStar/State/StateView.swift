// StateView.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояния View в зависимости от наличия данных
enum StateView {
    /// Запрос проинициализирован
    case initial
    /// Запрос данных загружается
    case loading
    /// Запрос данных выполнен
    case success([FilmsDTO])
    /// Неудачный запрос данных
    case failure
}
