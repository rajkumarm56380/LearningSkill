import Foundation

let postURL = "https://jsonplaceholder.typicode.com/posts/1"

func fetchUser() async throws -> String {
    try await Task.sleep(nanoseconds: 1)
    return "Testing"
}

func fetchUser(userId: String) async throws -> User {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(userId)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(User.self, from: data)
}

func loadData() async throws {
    let data1 = try await fetchUser()
    let data2 = try await fetchUser()
    let data3 = try await fetchUser()

    print("Data1 ==> \(data1), Data2 ==> \(data2), Data3 ==> \(data3)")
}

func fetchMessage() async -> String {
    return "Fetching Message ..."
}

func loadDataTask() {
    Task {
        do {
            try await loadData()
        }catch {
            print(error)
        }
    }
}

func loadTask() {
    Task {
        let result = await fetchMessage()
        print("result ==> \(result)")
    }
}

func fetchUsers() async throws -> [User] {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([User].self, from: data)
}

func loadUsers() {
    Task {
        do {
            let users = try await fetchUsers()
            print(users)
        } catch {
            print(error)
        }
    }
}

func fetchAll() async throws -> [User] {
    try await withThrowingTaskGroup(of: User.self) { group in
        for id in 1...5 {
            group.addTask {
                try await fetchUser(userId: String(id))
            }
        }
        var users: [User] = []
        for try await user in group {
            users.append(user)
        }
        return users
    }
}

func fetchAllUsers() async throws -> [User] {
    try await withThrowingTaskGroup(of: User.self) { group in
        for id in 1...5 {
            group.addTask {
                try await fetchUser(userId: String(id))
            }
        }
        var users: [User] = []
        for try await user in group {
            users.append(user)
        }
        return users
    }
}

// Structured Concurrency
func processOrders() async {
    async let order1 = fetchUser(userId: String(1))
    async let order2 = fetchUser(userId: String(2))

    do {
        let results = try await [order1, order2]
        print("User details: \(results)")
    }catch {
        print("Error \(error)")
    }
}

func fetchUser(task: Int) async throws -> String {
    try await Task.sleep(nanoseconds: 1_000_000)
    return "User task id ===> \(task) \n"
}

func loadUsersData() async throws -> String {
    let data1 = try await fetchUser(task: 1)
    let data2 = try await fetchUser(task: 2)
    let data3 = try await fetchUser(task: 3)
    return "Fetching User \nData1 ==> \(data1), Data2 ==> \(data2), Data3 ==> \(data3)"
}


Task {
    do {
        let users = try await loadUsersData()
        print(users)
    } catch {
        print("Failed to load data: \(error)")
    }
}

loadTask()


func fetchUserData() async throws -> User {
    let url = URL(string: postURL)!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(User.self, from: data)
}

func displayUserData() async {
    do {
        let userData = try await fetchUserData()
        print("Title: \(userData.title)")
        print("Body: \(userData.title)")
    } catch {
        print("Failed to fetch user data: \(error)")
    }
}

func fetchPostLists() async throws -> [User] {
    let url = URL(string: postURL)!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([User].self, from: data)
}

func getPostList() async {
    Task {
        do {
            let result = try await fetchPostLists()
        }catch {
            print("Post List failed \(error)")
        }
    }
}
Task {
    await displayUserData()
}

Task.detached {
    //let result = await performHeavyComputation()
    //print("Computation result: \(result)")
}

func monitorSensorReadings() -> AsyncStream<Int> {
    AsyncStream(Int.self) { continuation in
        // Launch async work in a Task because the builder must be synchronous
        Task {
            for i in 1...3 {
                continuation.yield(i)
                try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
            continuation.finish()
        }
    }
}

func callAsyncStream() {
    Task {
        for await reading in monitorSensorReadings() {
            print("Sensor reading: \(reading)")
        }
    }
}

callAsyncStream()


func doSomethingAsync() async -> String {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return "Hello, world!"
}

func callDoSomethingAsync() {
    Task {
         await doSomethingAsync()
    }
}

callDoSomethingAsync()
