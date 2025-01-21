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
    func test_API_getPeopleSucceed() async throws {
        let sut = makeSUT()
        let url = "https://swapi.tech/api/people"
        let response = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        var cancellable = Set<AnyCancellable>()
        
        let sampleData = try! JSONEncoder().encode(makePeopleReponseMock())
        
        URLSessionMock.mockResponse = (sampleData, response, nil)
        
        var peopleList = [People]()
        let exp = XCTestExpectation(description: "wait for it")
        
        sut.getPeople()
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(_):
                    print("error")
                }
            } receiveValue: { people in
                peopleList = people.results
                exp.fulfill()
            }
            .store(in: &cancellable)

        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(peopleList.count, 2, "Expected count 2, received: \(peopleList.count)")
    }
//    
//    func test_API_returnsBadURLError() async {
//        let wrongURL = "someBadURL"
//        let sut = makeSUT(url: wrongURL)
//        
//        do {
//            _ = try await sut.getPeople()
//            assertionFailure("Shouldn't succeed")
//        } catch {
//            XCTAssertEqual(error as? URLError, URLError(.badURL))
//        }
//    }
//    
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
    
    private func makeSUT(url: String = "https://swapi.tech/api/people") -> API {
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
