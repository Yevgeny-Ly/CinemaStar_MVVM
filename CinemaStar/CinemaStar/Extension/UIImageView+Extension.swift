// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImageView {
    /// Расширение выполнения запроса по загрузке картинки
    /// - Parameter link: ссылка
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }

        if let cachedImage = ImageCache.shared.image(for: url) {
            image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, error == nil else {
                    print("Ошибка загрузки картинки: \(error?.localizedDescription ?? "")")
                    return
                }

                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.saveImage(image, for: url)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }.resume()
        }
    }
}
