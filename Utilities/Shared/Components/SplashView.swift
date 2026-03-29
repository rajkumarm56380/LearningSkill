//
//  SplashView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

import SwiftUI

struct SplashView: View {

    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var session: SessionManager

    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.5

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.pink, .purple]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {

                Image("SplashScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 600, height: 700)
                    .scaleEffect(scale)
                    .opacity(opacity)

                Text("Food Recipes")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(opacity)
            }
        }
        .onAppear {
            animate()
            navigate()
        }
    }
}

// MARK: - Private Methods
private extension SplashView {

    func animate() {

        withAnimation(.easeIn(duration: 1.0)) {
            scale = 1.0
            opacity = 1.0
        }
    }

    func navigate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if session.isLoggedIn {
                router.reset(to: .foodLists)
            } else {
                router.reset(to: .login)
            }
        }
    }
}
