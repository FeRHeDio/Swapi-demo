//
//  SwapiDemoTests.swift
//  SwapiDemoTests
//
//  Created by Fernando Putallaz on 23/12/2024.
//

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
        
        let sampleData = try! JSONEncoder().encode(makePeopleReponseMock())
        
        URLSessionMock.mockResponse = (sampleData, response, nil)
        
        let peopleList = try await sut.getPeople()
        
        XCTAssertEqual(peopleList.count, 2, "Expected count 2, received: \(peopleList.count)")
        
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> API {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLSessionMock.self]
        let mockSession = URLSession(configuration: config)
        
        return API(session: mockSession)
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

private class URLSessionMock: URLProtocol {
    static var mockResponse: (Data?, URLResponse?, Error?)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        print("Request intercepted: \(request.url?.absoluteString ?? "Unknown URL")")
        if let (data, response, error) = URLSessionMock.mockResponse {
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            if let response = response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
            } else {
                print("No mock response set!")
                client?.urlProtocolDidFinishLoading(self)
            }
        }
        
    }
    
    override func stopLoading() {}
}
