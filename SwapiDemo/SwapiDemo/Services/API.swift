//
//  API.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 23/12/2024.
//

import Foundation

class API {
    private var session: URLSession
    
    let baseURL = "https://swapi.tech/api/people"
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getPeople() async throws -> [People] {
        do {
            guard let url = URL(string: baseURL) else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            guard httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let peopleResponse = try JSONDecoder().decode(PeopleResponse.self, from: data)
            
            return peopleResponse.results
            
        } catch {
            throw URLError(.unknown)
        }
    }
}

struct PeopleResponse: Codable {
    let message: String
    let records: Int
    let pages: Int
    let results: [People]
}

struct People: Codable {
    let uid: String
    let name: String
    let url: String
}
