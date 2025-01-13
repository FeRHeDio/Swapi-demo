//
//  API.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 23/12/2024.
//

import Foundation

class API {
    private var session: URLSession
    private var baseURL: String
    var nextURL: String?
    
    init(
        session: URLSession = .shared,
        baseURL: String = "https://swapi.tech/api/people"
    ) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getPeople() async throws -> [People] {
        var urlString = ""
        
        if let nextURL {
            urlString = nextURL
        } else {
            urlString = baseURL
        }
        
        do {
            guard let url = URL(string: urlString), url.scheme != nil, url.host != nil else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse )
            }
            
            guard httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let peopleResponse = try JSONDecoder().decode(PeopleResponse.self, from: data)
            
            nextURL = peopleResponse.next
            
            return peopleResponse.results
            
        } catch let error{
            throw error
        }
    }
}

extension API {
    
    func getPeopleFromURL(_ urlString: String) async throws -> PeopleResponse {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse )
        }
        
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let peopleResponse = try JSONDecoder().decode(PeopleResponse.self, from: data)
        
        return peopleResponse
    }
}
