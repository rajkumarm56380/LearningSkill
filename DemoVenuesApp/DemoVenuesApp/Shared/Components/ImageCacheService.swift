//
//  ImageCacheService.swift
//  DemoVenuesApp
//
//

import Foundation
import UIKit

final class ImageCacheService {

    static let shared = ImageCacheService()

    private let cache = NSCache<NSString, UIImage>()

    func getImage(for key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func saveImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
