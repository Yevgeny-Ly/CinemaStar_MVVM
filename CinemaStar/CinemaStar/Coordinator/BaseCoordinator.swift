// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Изначальный координатор
class BaseCoordinator {
    // MARK: - Public Properties

    var childCoordinator: [BaseCoordinator] = []

    // MARK: - Public Methods

    func start() {
        fatalError("child должен быть реализован")
    }

    func add(coordinator: BaseCoordinator) {
        childCoordinator.append(coordinator)
    }

    func remove(coordinator: BaseCoordinator) {
        childCoordinator = childCoordinator.filter { $0 !== coordinator }
    }

    func setAsRoot(_ controller: UIViewController) {
        let window = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap(\.windows)
            .last { $0.isKeyWindow }
        window?.rootViewController = controller
    }
}
