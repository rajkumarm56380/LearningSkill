//
//  LoginView.swift
//  DBDemo
//
//
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = AuthViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $vm.email)
                SecureField("Password", text: $vm.password)
                Button("Login") { vm.login() }
                NavigationLink("Signup", destination: SignupView())
            }.padding()
        }
    }
}

#Preview {
    LoginView()
}
