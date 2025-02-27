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
    var showProgressView: Bool = false
    
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
                self.showProgressView = true
                api.getPeople(from: url)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("finished loading page \(url)")
                        case .failure(_):
                            self.state = .error
                        }
                    }, receiveValue: { [weak self] response in
                        guard let self else { return }
                        
                        self.allCharacters.append(contentsOf: response.results)
                        self.state = .loaded(characters: self.allCharacters)
                        self.nextPageURL = response.next
                        self.showProgressView = false
                    })
                    .store(in: &cancellable)
            }
        }
    }
    
    func refreshData() async {
        await sleepSafelyFor(1.0)
        cancellable.removeAll()
        allCharacters.removeAll()
        nextPageURL = "https://swapi.tech/api/people"
        getPeople()
    }
    
    func sleepSafelyFor(_ seconds: Double) async {
        try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}
