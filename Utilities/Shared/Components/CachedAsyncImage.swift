//
//  CachedAsyncImage.swift
//  DemoVenuesApp
//
//

import SwiftUI

struct CachedAsyncImage: View {

    @StateObject private var loader = ImageLoader()
    let url: String

    var body: some View {
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
        .onAppear {
            loader.load(urlString: url)
        }
    }
}
