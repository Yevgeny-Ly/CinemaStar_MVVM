// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIViewController {
    /// Расширение для вызова алерта
    func callAlert(message: String) {
        let alert = UIAlertController(title: "Упс", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
