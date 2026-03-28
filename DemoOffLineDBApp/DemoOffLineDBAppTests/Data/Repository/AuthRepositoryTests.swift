//
//  AuthRepositoryTests.swift
//  DemoOffLineDBAppTests
//
//

import XCTest
@testable import DemoOffLineDBApp

final class AuthRepositoryTests: XCTestCase {

    var repository: AuthRepository!
    var mockRemote: MockAuthService!          // ← remote = MockAuthService (not MockAuthRepository)
    var mockLocal: MockLocalAuthDataSource!
    var mockNetwork: MockNetworkMonitor!

    override func setUp() {
        super.setUp()
        mockRemote = MockAuthService()
        mockLocal = MockLocalAuthDataSource()
        mockNetwork = MockNetworkMonitor()

        repository = AuthRepository(
            remote: mockRemote,        // MockAuthService implements AuthServiceProtocol
            local: mockLocal,          // MockLocalAuthDataSource implements LocalAuthDataSourceProtocol
            network: mockNetwork       // MockNetworkMonitor implements NetworkMonitorProtocol
        )
    }
    override func tearDown() {
        repository = nil
        mockRemote = nil
        mockLocal = nil
        mockNetwork = nil
        super.tearDown()
    }

    func test_login_online_success_savesUser() async throws {
        mockNetwork.isConnected = true

        let user = try await repository.login(email: "test@test.com", password: "123456")

        XCTAssertEqual(user.email, "test@test.com")
        XCTAssertTrue(mockLocal.saveCalled)
    }

    func test_login_online_failure_throwsError() async {
        mockNetwork.isConnected = true
        mockRemote.shouldFail = true

        do {
            _ = try await repository.login(email: "test@test.com", password: "123456")
            XCTFail("Expected error")
        } catch {
            XCTAssertFalse(mockLocal.saveCalled)
        }
    }

    func test_login_offline_success_returnsLocalUser() async throws {
        mockNetwork.isConnected = false

        mockLocal.storedUser = LocalUser(
            id: UUID().uuidString,
            name: "Offline User",
            email: "offline@test.com",
            isLoggedIn: true
        )

        let user = try await repository.login(email: "", password: "")

        XCTAssertEqual(user.email, "offline@test.com")
    }

    func test_login_offline_noUser_throwsError() async {
        mockNetwork.isConnected = false
        mockLocal.storedUser = nil

        do {
            _ = try await repository.login(email: "", password: "")
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(true)
        }
    }

    func test_signup_online_success() async throws {
        mockNetwork.isConnected = true

        let input = User(
            id: UUID(),
            name: "Test",
            email: "test@test.com",
            password: "123456",
            isLoggedIn: false
        )

        let user = try await repository.signup(user: input)

        XCTAssertEqual(user.email, "test@test.com")
    }

    func test_signup_online_failure() async {
        mockNetwork.isConnected = true
        mockRemote.shouldFail = true

        let input = User(
            id: UUID(),
            name: "Test",
            email: "test@test.com",
            password: "123456",
            isLoggedIn: false
        )

        do {
            _ = try await repository.signup(user: input)
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(true)
        }
    }

    func test_signup_offline_returnsLocalUser() async throws {
        mockNetwork.isConnected = false

        mockLocal.storedUser = LocalUser(
            id: UUID().uuidString,
            name: "Offline User",
            email: "offline@test.com",
            isLoggedIn: true
        )

        let input = User(
            id: UUID(),
            name: "New User",
            email: "new@test.com",
            password: "123456",
            isLoggedIn: false
        )

        let user = try await repository.signup(user: input)

        XCTAssertEqual(user.email, "offline@test.com")
    }

    func test_getCurrentUser_returnsUser() {
        mockLocal.storedUser = LocalUser(
            id: UUID().uuidString,
            name: "Test",
            email: "test@test.com",
            isLoggedIn: true
        )

        let user = repository.getCurrentUser()

        XCTAssertNotNil(user)
        XCTAssertEqual(user?.email, "test@test.com")
    }

    func test_getCurrentUser_returnsNil_whenNoUser() {
        mockLocal.storedUser = nil

        let user = repository.getCurrentUser()

        XCTAssertNil(user)
    }

    func test_logout_callsRemoteAndLocal() async throws {
        try await repository.logout()

        XCTAssertTrue(mockLocal.logoutCalled)
    }

    func test_logout_remoteFails_stillTestable() async {
        mockRemote.shouldFail = true
        print("shouldFail is: \(mockRemote.shouldFail)")
        do {
            try await repository.logout()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertFalse(mockLocal.logoutCalled, "Local logout should not be called if remote fails")

        }
    }
}

