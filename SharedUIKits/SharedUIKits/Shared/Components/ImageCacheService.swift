//
//  ImageCacheService.swift
//  DemoOffLineDBApp
//
//

import Foundation
import UIKit

public final class ImageCacheService {

    static let shared = ImageCacheService()

    private let cache = NSCache<NSString, UIImage>()

    public func getImage(for key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    public func saveImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

