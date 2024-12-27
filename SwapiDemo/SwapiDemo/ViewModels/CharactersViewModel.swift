//
//  CharactersViewModel.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 24/12/2024.
//

import Foundation

@Observable
class CharactersViewModel {
    enum LoadingState {
        case loading
        case loaded(characters: [People])
        case error
    }
    
    var peopleList = [People]()
    let api: API?
    var state = LoadingState.loading
    var useMockData: Bool
    
    init(peopleList: [People] = [People](), api: API? = nil, useMockData: Bool = false) {
        self.peopleList = peopleList
        self.api = api
        self.useMockData = useMockData
    }
    
    func getData() async {
        if useMockData {
            state = .loaded(characters: People.mockData())
        } else {
            state = .loading
            do {
                if let api {
                    state = .loaded(characters: try await api.getPeople())
                }
            } catch {
                state = .error
            }
        }
    }
}
