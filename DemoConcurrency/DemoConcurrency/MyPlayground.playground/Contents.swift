import UIKit
import Combine

func fetchUser(task: Int) async throws -> String {
    try await Task.sleep(nanoseconds: 1)
    return "Testing --> \(task)"
}

func loadData() {
    
    let data1 = try await fetchUser(task: 1)
    let data2 = try await fetchUser(task: 2)
    let data3 = try await fetchUser(task: 3)
    return ("Fetching User \n Data1 ==> \(data1), Data2 ==> \(data2), Data3 ==> \(data3)")
 }

func fetchMessage() async throws -> String {
    return "Fetching Message ..."
}

func loadTask() async throws {
    Task {
        await fetchMessage()
    }
}

loadData()
loadTask()

