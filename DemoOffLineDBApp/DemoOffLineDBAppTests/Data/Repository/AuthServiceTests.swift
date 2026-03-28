//
//  AuthServiceTests.swift
//  DemoOffLineDBAppTests
//
//

import XCTest
@testable import DemoOffLineDBApp

final class AuthServiceTests: XCTestCase {

    var service: MockAuthService!

    override func setUp() {
        super.setUp()
        service = MockAuthService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func test_login_success_returnsUser() async throws {
        let user = try await service.login(email: "test@test.com", password: "123456")

        XCTAssertEqual(user.email, "test@test.com")
        XCTAssertTrue(user.isLoggedIn)
    }

    func test_login_failure_throwsError() async {
        service.shouldFail = true

        do {
            _ = try await service.login(email: "test@test.com", password: "123456")
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(true)
        }
    }

    func test_signup_success_returnsUser() async throws {
        let input = User(
            id: UUID(),
            name: "Test",
            email: "test@test.com",
            password: "123456",
            isLoggedIn: false
        )

        let user = try await service.signup(user: input)

        XCTAssertEqual(user.email, "test@test.com")
    }

    func test_signup_failure_throwsError() async {
        service.shouldFail = true

        let input = User(
            id: UUID(),
            name: "Test",
            email: "test@test.com",
            password: "123456",
            isLoggedIn: false
        )

        do {
            _ = try await service.signup(user: input)
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(true)
        }
    }

    func test_logout_clearsUser() async throws {
        _ = try await service.login(email: "test@test.com", password: "123456")

        try await service.logout()

        XCTAssertNil(service.currentUser)
    }

    func test_observeAuthState_emitsLogin() async throws {
        let stream = service.observeAuthState()
        var iterator = stream.makeAsyncIterator()

        _ = await iterator.next() // initial nil

        _ = try await service.login(email: "test@test.com", password: "123456")

        let loggedInUser = await iterator.next()

        XCTAssertEqual(loggedInUser??.email, "test@test.com")
    }

}
