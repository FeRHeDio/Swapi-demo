//
//  CharactersViewModel.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 24/12/2024.
//

import Foundation
import Combine

@Observable
class CharactersViewModel {
    enum LoadingState {
        case loading
        case loaded(characters: [People])
        case error
    }
    
    private var allCharacters = [People]()
    var nextPageURL: String? = "https://swapi.tech/api/people"
    var cancellable = Set<AnyCancellable>()
    let api: API?
    var state = LoadingState.loading
    var useMockData: Bool
    
    init(api: API? = nil, useMockData: Bool = false) {
        self.api = api
        self.useMockData = useMockData
        getPeople()
    }
    
    func getPeople() {
        if useMockData {
            state = .loaded(characters: People.mockData())
        } else {
            guard let url = nextPageURL else { return }
            
            if let api {
                api.getPeople(from: url)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("finished")
                        case .failure(_):
                            self.state = .error
                        }
                    }, receiveValue: { [weak self] response in
                        guard let self else { return }
                        
                        self.allCharacters.append(contentsOf: response.results)
                        
                        self.state = .loaded(characters: self.allCharacters)
                        self.nextPageURL = response.next
                    })
                    .store(in: &cancellable)
            }
        }
    }
}
