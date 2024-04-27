// ImageCache.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Реализует кеширование картинки
final class ImageCache {
    // MARK: - Public Properties

    static let shared = ImageCache()

    // MARK: - Private Properties

    private var cache = NSCache<NSURL, UIImage>()

    // MARK: - Public Methods

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func saveImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }

    func clearCache() {
        cache.removeAllObjects()
    }
}
