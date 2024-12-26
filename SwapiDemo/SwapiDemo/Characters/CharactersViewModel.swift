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
    let api: API
    var state = LoadingState.loading
    
    init(peopleList: [People] = [People](), api: API) {
        self.peopleList = peopleList
        self.api = api
    }
    
    func getData() async {
        state = .loading
        do {
           state = .loaded(characters: try await api.getPeople())
        } catch {
            state = .error
        }
    }
}
