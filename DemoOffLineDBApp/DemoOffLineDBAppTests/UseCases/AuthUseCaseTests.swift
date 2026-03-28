//
//  AuthUseCaseTests.swift
//  DemoOffLineDBAppTests
//
//

import XCTest
@testable import DemoOffLineDBApp

final class AuthUseCaseTests: XCTestCase {

    var mockRepo: MockAuthRepository!
    var useCase: AuthUseCase!

    override func setUp() {
        super.setUp()
        mockRepo = MockAuthRepository()
        useCase = AuthUseCase(repo: mockRepo)
    }

    override func tearDown() {
        mockRepo = nil
        useCase = nil
        super.tearDown()
    }

    // MARK: - Login Success
    func test_login_success() async throws {
        mockRepo.shouldFail = false

        let user = try await useCase.executeLogin(email: "test@test.com", password: "password")

        XCTAssertTrue(mockRepo.loginCalled, "Login should call repository login")
        XCTAssertEqual(user.email, "test@test.com")
    }

    // MARK: - Login Failure
    func test_login_failure() async {
        mockRepo.shouldFail = true

        do {
            _ = try await useCase.executeLogin(email: "test@test.com", password: "password")
            XCTFail("Login should throw an error")
            XCTFail("Expected login to fail, but it succeeded")
        } catch {
            XCTAssertTrue(mockRepo.loginCalled)
            XCTAssertEqual(error.localizedDescription, "Invalid or expired credentials")
        }
    }

    // MARK: - Signup Success
    func test_signup_success() async throws {
        mockRepo.shouldFail = false
        let newUser = User(id: UUID(), name: "New User", email: "new@test.com", password: "123456")

        let user = try await useCase.executeSignup(user: newUser)

        XCTAssertTrue(mockRepo.signupCalled, "Signup should call repository signup")
        XCTAssertEqual(user.email, "new@test.com")
        XCTAssertEqual(user.name, "New User")
    }

    // MARK: - Signup Failure
    func test_signup_failure() async {
        mockRepo.shouldFail = true
        let newUser = User(id: UUID(), name: "New User", email: "new@test.com", password: "123456")

        do {
            _ = try await useCase.executeSignup(user: newUser)
            XCTFail("Signup should throw an error")
        } catch {
            XCTAssertTrue(mockRepo.signupCalled)
            XCTAssertEqual(error.localizedDescription, "Email already in use")
        }
    }
}
