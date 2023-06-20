//
//  GitAppTests.swift
//  GitAppTests

import XCTest
@testable import GitApp

final class GitAppTests: XCTestCase {

    func test_onFetchDataSuccessShouldPresentLoginAndDescription() throws {
        // Given
        let descriptionAssert = "Some description"
        let loginAssert = "Login description"
        
        let stub = APIStub(description: descriptionAssert, login: loginAssert)
        
        let expectation = XCTestExpectation(description: "waiting tests")
        let spy = SomeDelegateSpy(expectation: expectation)
        let sut = MainViewModel(api: stub, delegate: spy)
        
        // When
        sut.fetchData()
        
        // Than
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(spy.loginWasPassed, loginAssert)
        XCTAssertEqual(spy.descriptionWasPassed, descriptionAssert)
    }
}

final class SomeDelegateSpy: MainDelegate {
    
    private let expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    private(set) var loginWasPassed: String?
    private(set) var descriptionWasPassed: String?
    func presentData(login: String, description: String) {
        loginWasPassed = login
        descriptionWasPassed = description
        expectation.fulfill()
    }
    
    private(set) var errorMessageWasPassed: String?
    func presentError(message: String) {
        errorMessageWasPassed = message
    }
}

final class APIStub: APIProtocol {
    
    private let description: String
    private let login: String
    
    init(description: String, login: String) {
        self.description = description
        self.login = login
    }
    
    func getGists(session: URLSession, endpoint: Endpoint, completion: @escaping (Result<Gist, GitAppError>) -> Void) {
        completion(
            .success(
                .init(
                    description: description,
                    owner: .init(login: login)
                )
            )
        )
    }
}
