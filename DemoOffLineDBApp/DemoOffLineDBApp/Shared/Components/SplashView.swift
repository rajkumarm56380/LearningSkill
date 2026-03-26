//
//  SplashView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct SplashView: View {

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Image("ImageBG")
                    .resizable()
            }
        }
        .ignoresSafeArea()
    }
}
