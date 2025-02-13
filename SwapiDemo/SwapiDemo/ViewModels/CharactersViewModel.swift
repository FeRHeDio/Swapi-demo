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
    
    var nextPageURL: String?
    var currentPageURL = "https://swapi.tech/api/people"
    var cancellable = Set<AnyCancellable>()
    var peopleList = [People]()
    let api: API?
    var state = LoadingState.loading
    var useMockData: Bool
    
    init(peopleList: [People] = [People](), api: API? = nil, useMockData: Bool = false) {
        self.peopleList = peopleList
        self.api = api
        self.useMockData = useMockData
        getPeople()
    }
    
    func getPeople() {
        if useMockData {
            state = .loaded(characters: People.mockData())
        } else {
            let url = nextPageURL ?? currentPageURL
            
            if let api {
                api.getPeople(from: url)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("finished")
                        case .failure(_):
                            self.state = .error
                        }
                    }, receiveValue: { [weak self] val in
                        guard let self else { return }
                        
                        self.state = .loaded(characters: val.results)
                    })
                    .store(in: &cancellable)
            }
        }
    }
}
