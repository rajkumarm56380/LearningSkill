//
//  SignupView.swift
//  DBDemo
//
//
//

import SwiftUI

struct SignupView: View {
    @StateObject var vm = AuthViewModel(container: DependencyContainer.shared)

    var body: some View {
        VStack {
            TextField("Email", text: $vm.email)
            SecureField("Password", text: $vm.password)
            Button("Signup") { vm.signup() }
        }.padding()
    }
}


#Preview {
    SignupView()
}
