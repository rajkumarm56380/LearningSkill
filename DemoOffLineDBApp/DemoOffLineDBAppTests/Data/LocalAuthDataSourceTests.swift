//
//  LocalAuthDataSourceTests.swift
//  DemoOffLineDBAppTests
//
//

import XCTest
import SwiftData
@testable import DemoOffLineDBApp

final class LocalAuthDataSourceTests: XCTestCase {

    var container: ModelContainer!
    var context: ModelContext!
    var dataSource: LocalAuthDataSource!

    override func setUp() {
        super.setUp()

        do {
            container = try ModelContainer(
                for: LocalUser.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            context = ModelContext(container)
            dataSource = LocalAuthDataSource(context: context)
        } catch {
            XCTFail("Failed to setup SwiftData: \(error)")
        }
    }

    override func tearDown() {
        container = nil
        context = nil
        dataSource = nil
        super.tearDown()
    }

    // TEST: Save + Fetch
    func test_save_and_fetch_user() throws {

        // GIVEN
        let user = User(
            id: UUID(),
            name: "Raj",
            email: "raj@test.com",
            password: "",
            isLoggedIn: true
        )

        // WHEN
        dataSource.saveUser(user)
        let fetched = dataSource.fetchLoggedInUser()

        // THEN
        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?.name, "Raj")
        XCTAssertEqual(fetched?.email, "raj@test.com")
        XCTAssertTrue(fetched?.isLoggedIn == true)
    }

    func test_logout_setsUserLoggedOut() {

        // GIVEN
        let user = User(
            id: UUID(),
            name: "Raj",
            email: "raj@test.com",
            password: "",
            isLoggedIn: true
        )

        dataSource.saveUser(user)

        // WHEN
        dataSource.logout()

        let fetched = dataSource.fetchLoggedInUser()

        // THEN
        XCTAssertNil(fetched)
    }

    func test_multiple_users_onlyOneLoggedIn() {

        let user1 = User(
            id: UUID(),
            name: "User1",
            email: "u1@test.com",
            password: "",
            isLoggedIn: true
        )

        let user2 = User(
            id: UUID(),
            name: "User2",
            email: "u2@test.com",
            password: "",
            isLoggedIn: true
        )

        dataSource.saveUser(user1)
        dataSource.saveUser(user2)

        let fetched = dataSource.fetchLoggedInUser()

        XCTAssertNotNil(fetched)
    }
    
}
