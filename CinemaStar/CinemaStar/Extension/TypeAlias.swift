// TypeAlias.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// swiftlint:disable all
/// Обрабатывает замыкание которое ничего не принимает
public typealias VoidHandler = () -> ()
/// Обрабатывает замыкание которое принимает Bool значение
public typealias BoolHandler = (Bool) -> ()
/// Обрабатывает замыкание которое принимает String значение
public typealias StringHandler = (String) -> ()
/// Обрабатывает замыкание которое принимает Date значение
public typealias DateHandler = (Date) -> ()
/// Обрабатывает замыкание которое принимает значение Date опциональное
public typealias OptionalDateHandler = (Date?) -> ()
// swiftlint:enable all
