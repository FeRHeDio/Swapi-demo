//
//  API.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 23/12/2024.
//

import Combine
import Foundation

class API {
    private var session: URLSession
    private var baseURL: String?
    
    init(
        session: URLSession = .shared,
        baseURL: String?
    ) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getPeople(from url: String) -> AnyPublisher<PeopleResponse, Error> {
        guard let url = URL(string: url),
              url.scheme == "http" || url.scheme == "https",
              url.host != nil else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: PeopleResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
