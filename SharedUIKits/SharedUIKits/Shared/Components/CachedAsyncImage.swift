//
//  CachedAsyncImage.swift
//  DemoVenuesApp
//
//

import SwiftUI

public struct CachedAsyncImage: View {

    @StateObject private var loader = ImageLoader()
    public let url: String

    public init(url: String) {
        self.url = url
    }

    public var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    Color.gray.opacity(0.2)
                    ProgressView()
                }
            }
        }
        .task {
            loader.load(urlString: url)
        }
    }
}
