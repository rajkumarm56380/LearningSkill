//
//  SDWebImageView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI
import SDWebImageSwiftUI

struct SDWebImageView: View {
    let imageUrl: String
    var body: some View {
        WebImage(url: URL(string: imageUrl))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
    }
}

