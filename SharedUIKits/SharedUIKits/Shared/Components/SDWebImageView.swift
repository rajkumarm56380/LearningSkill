//
//  SDWebImageView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI
internal import SDWebImageSwiftUI

public struct SDWebImageView: View {
    public let imageUrl: String

    public init(imageUrl: String) {
        self.imageUrl = imageUrl
    }

    public  var body: some View {
        WebImage(url: URL(string: imageUrl))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
    }
}

