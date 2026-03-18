//
//  ImageLoader.swift
//  DemoVenuesApp
//
//

import Combine
import Foundation
import UIKit

final class ImageLoader: ObservableObject {

    @Published var image: UIImage?

    private var cancellable: AnyCancellable?

    func load(urlString: String) {

        // ✅ 1. Check cache first
        if let cached = ImageCacheService.shared.getImage(for: urlString) {
            self.image = cached
            return
        }

        guard let url = URL(string: urlString) else { return }

        // ✅ 2. Fetch from network
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self, let image = image else { return }

                // ✅ 3. Save to cache
                ImageCacheService.shared.saveImage(image, for: urlString)
                self.image = image
            }
    }
}
