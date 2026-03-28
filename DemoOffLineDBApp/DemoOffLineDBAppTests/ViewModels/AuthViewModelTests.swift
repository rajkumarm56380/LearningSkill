//
//  AuthViewModelTests.swift
//  DemoOffLineDBAppTests
//
//

import XCTest
import Combine
@testable import DemoOffLineDBApp

@MainActor
final class AuthViewModelTests: XCTestCase {

    var mockRepo: MockAuthUseCase!
    var viewModel: AuthViewModel!
    var session: SessionManager!
    var authService: MockAuthService!
    var mockAuthRepo: MockAuthRepository!

    override func setUp() {
        super.setUp()
        authService = MockAuthService()
        mockAuthRepo = MockAuthRepository()
        mockRepo = MockAuthUseCase()
        session = SessionManager(repo: mockAuthRepo, service: authService)
        viewModel = AuthViewModel(repo: mockRepo, session: session, router: AppRouter())
    }


    override func tearDown() {
        authService = nil
        mockAuthRepo = nil
        viewModel = nil
        mockRepo = nil
        session = nil
        super.tearDown()
    }

    func test_login_success_sets_loggedUser() async throws {
        // Arrange
        viewModel.email = "test@test.com"
        viewModel.password = "Password1!"

        // Act
        viewModel.login()
        try await Task.sleep(nanoseconds: 100_000_000) // wait for internal Task

        // Assert
        XCTAssertNotNil(viewModel.loggedUser)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    // MARK: - Login Failure

    func test_login_failure_sets_errorMessage() async throws {
        // Arrange
        mockRepo.shouldFailLogin = true
        viewModel.email = "test@test.com"
        viewModel.password = "Password1!"

        // Act
        viewModel.login()
        try await Task.sleep(nanoseconds: 100_000_000)

        // Assert
        XCTAssertNil(viewModel.loggedUser)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    // MARK: - Login Validation Failure (empty fields)

    func test_login_with_invalid_email_does_not_call_repo() async throws {
        // Arrange — email/password left empty (default "")
        // Act
        viewModel.login()

        // Assert — validation should block before repo is called
        XCTAssertFalse(mockRepo.loginCalled)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    // MARK: - Signup Success

    func test_signup_success_sets_loggedUser() async throws {
        // Arrange
        viewModel.name = "John"
        viewModel.email = "john@test.com"
        viewModel.password = "Password1!"
        viewModel.confirmPassword = "Password1!"

        // Act
        viewModel.signup()
        try await Task.sleep(nanoseconds: 100_000_000)

        // Assert
        XCTAssertNotNil(viewModel.loggedUser)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    // MARK: - Signup Failure

    func test_signup_failure_sets_errorMessage() async throws {
        // Arrange
        mockRepo.shouldFailSignup = true
        viewModel.name = "John"
        viewModel.email = "john@test.com"
        viewModel.password = "Password1!"
        viewModel.confirmPassword = "Password1!"

        // Act
        viewModel.signup()
        try await Task.sleep(nanoseconds: 100_000_000)

        // Assert
        XCTAssertNil(viewModel.loggedUser)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    // MARK: - Signup Validation Failure

    func test_signup_with_mismatched_passwords_does_not_call_repo() {
        // Arrange
        viewModel.name = "John"
        viewModel.email = "john@test.com"
        viewModel.password = "Password1!"
        viewModel.confirmPassword = "Different1!"

        // Act
        viewModel.signup()

        // Assert
        XCTAssertFalse(mockRepo.signupCalled)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    // MARK: - isLoading resets after completion

    func test_isLoading_resets_to_false_after_login() async throws {
        viewModel.email = "test@test.com"
        viewModel.password = "Password1!"

        viewModel.login()
        XCTAssertTrue(viewModel.isLoading) // immediately true

        try await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertFalse(viewModel.isLoading) // false after task completes
    }

    func test_logout_success_clearsUser() async throws {
        // Arrange — simulate logged in state
        viewModel.loggedUser = mockRepo.stubbedUser

        // Act
        viewModel.logout()
        try await Task.sleep(nanoseconds: 100_000_000)

        // Assert
        XCTAssertTrue(mockRepo.logoutCalled)
        XCTAssertNil(viewModel.loggedUser)
    }

    func test_logout_failure_setsErrorMessage() async throws {
        // Arrange
        mockRepo.shouldFailLogout = true

        // Act
        viewModel.logout()
        try await Task.sleep(nanoseconds: 100_000_000)

        // Assert
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
