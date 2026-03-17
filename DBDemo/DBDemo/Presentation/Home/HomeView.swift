//
//  HomeView.swift
//  DBDemo
//
//
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel(useCase: DependencyContainer.shared.itemUseCase)

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter item", text: $vm.inputText)
                Button("Add") { vm.addItem() }
                List {
                    ForEach(vm.items) { item in
                        Text(item.title)
                    }
                    .onDelete { indexSet in
                        vm.deleteItem(at: indexSet)
                    }
                }
                Button("Delete All") { vm.deleteAll() }
                Button("Logout") { SessionManager.shared.isLoggedIn = false }
            }
        }
    }
}

#Preview {
    HomeView()
}
