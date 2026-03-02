//
//  UserDetailView.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        VStack {
            Text(user.name).font(.title)
            Text(user.email)
        }
    }
}

#Preview {
    UserDetailView(user: User(id: 1, name: "Rajkumar", email: "test@gmail.com"))
}
