//
//  SettingsView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {

                    VStack(spacing: 12) {

                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.purple)

                        //Text(session.user?.name ?? "Guest User")
                          //  .font(.headline)

                        Text(session.user?.email ?? "Guest User")
                            .font(.headline)

                        Text("Welcome to Food App 🍽️")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                }
                .padding()
            }
            VStack {
                Button {
                    logout()
                } label: {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppConstants.appColour)
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(Color(.systemGray6))
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.pop()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                    }
                }
            }
        }
        .appNavigationStyle()
    }

    // LOGOUT LOGIC
    private func logout() {
        session.logout()
        router.reset()
        router.push(.login)
    }
}
