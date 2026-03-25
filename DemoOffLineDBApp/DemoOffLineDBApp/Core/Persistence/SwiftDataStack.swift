//
//  SwiftDataStack.swift
//  DemoOffLineDBApp
//
 
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataStack {
    let container: ModelContainer
    lazy var context: ModelContext = container.mainContext

    init() {
        container = try! ModelContainer(for: CartEntity.self)
    }
}
