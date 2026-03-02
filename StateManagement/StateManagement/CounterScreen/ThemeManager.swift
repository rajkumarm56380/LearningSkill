//
//  ThemeManager.swift
//  StateManagement
//
//  Created by user on 02/03/26.
//
import Combine
import SwiftUI

final class ThemeManager: ObservableObject {
    @Published var primaryColor: Color = .blue
    @Published var isDarkMode: Bool = false

    func toggleTheme() {
        isDarkMode.toggle()
        primaryColor = isDarkMode ? .orange : .blue
    }
}
