//
//  SwapiDemoTests.swift
//  SwapiDemoTests
//
//  Created by Fernando Putallaz on 23/12/2024.
//

import Combine
import XCTest
@testable import SwapiDemo

final class SwapiDemoTests: XCTestCase {
    func test_API_getPeopleSucceed() {
        let url = "https://swapi.tech/api/people"
        let sut = makeSUT(url: url)
        let mockResponse = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        var cancellable = Set<AnyCancellable>()
        
        let mockData = try! JSONEncoder().encode(makePeopleReponseMock())
        
        URLSessionMock.mockResponse = (mockData, mockResponse, nil)
        
        var peopleList = [People]()
        let exp = XCTestExpectation(description: "wait for it")
        
        sut.getPeople(from: url)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Expected successful response but received failure")
                }
            } receiveValue: { people in
                peopleList = people.results
                exp.fulfill()
            }
            .store(in: &cancellable)

        wait(for: [exp], timeout: 1.0)
        
        let expectedResult = 2
        let receivedResult = peopleList.count
        
        XCTAssertEqual(receivedResult, expectedResult, "Expected count \(expectedResult), received: \(receivedResult) instead")
    }
    
    func test_API_returnsBadURLError() {
        let wrongURL = "bad_url"
        let sut = makeSUT(url: wrongURL)
        var cancellable = Set<AnyCancellable>()
        
        let exp = XCTestExpectation(description: "wait for it")
        
        sut.getPeople(from: wrongURL)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error as? URLError, URLError(.badURL))
                    exp.fulfill()
                } else {
                    XCTFail("Shouldn't succeed on a bad url!")
                    exp.fulfill()
                }
            } receiveValue: { _ in }
            .store(in: &cancellable)

        wait(for: [exp], timeout: 1.0)
    }
    
    func test_API_returnsBadServerResponse() {
        let wrongURL = "bad_url"
        let sut = makeSUT(url: wrongURL)
        var cancellable = Set<AnyCancellable>()
        
        let exp = XCTestExpectation(description: "wait for it")
        
        sut.getPeople(from: wrongURL)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error as? URLError, URLError(.badURL))
                    exp.fulfill()
                } else {
                    XCTFail("Shouldn't succeed on a bad url!")
                    exp.fulfill()
                }
            } receiveValue: { _ in }
            .store(in: &cancellable)

        wait(for: [exp], timeout: 1.0)
    }
    
//    func test_API_returnsBadResponseError() async {
//        let sut = makeSUT()
//        let url = "https://swapi.tech/api/people"
//        
//        let response = HTTPURLResponse(
//            url: URL(string: url)!,
//            statusCode: 300,
//            httpVersion: nil,
//            headerFields: nil
//        )
//        
//        URLSessionMock.mockResponse = (nil, response, nil)
//        
//        do {
//            _ = try await sut.getPeople()
//        } catch {
//            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
//        }
//    }
//    
//    func test_API_returnsBadHTTPResponse() async {
//        let sut = makeSUT()
//        let url = "https://swapi.tech/api/people"
//        
//        let response = URLResponse(
//            url: URL(string: url)!,
//            mimeType: nil,
//            expectedContentLength: 0,
//            textEncodingName: nil
//        )
//        
//        URLSessionMock.mockResponse = (nil, response, nil)
//        
//        do {
//            _ = try await sut.getPeople()
//        } catch {
//            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
//        }
//    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: String) -> API {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLSessionMock.self]
        let mockSession = URLSession(configuration: config)
        
        return API(session: mockSession, baseURL: url)
    }
    
    private func makePeopleReponseMock() -> PeopleResponse {
        PeopleResponse(
            message: "ok",
            records: 2,
            pages: 1,
            results: [
                People(
                    uid: "1",
                    name: "Luke Skywalker",
                    url: "https://swapi.tech/api/people/1"
                ),
                People(
                    uid: "2",
                    name: "Darth Vader",
                    url: "https://swapi.tech/api/people/2"
                ),
            ]
        )
    }
}
