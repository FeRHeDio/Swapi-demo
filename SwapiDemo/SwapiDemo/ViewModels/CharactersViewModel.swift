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
        case loaded
        case error
    }
    
    var peopleList = [People]()
    let api: API?
    var state = LoadingState.loading
    var useMockData: Bool
    var nextURL: String?
    
    var hasMorePages: Bool {
        nextURL != nil
    }
    
    init(peopleList: [People] = [People](), api: API? = nil, useMockData: Bool = false) {
        self.peopleList = peopleList
        self.api = api
        self.useMockData = useMockData
    }
    
    func getData() async {
        if useMockData {
            peopleList = People.mockData()
            state = .loaded
        } else {
            state = .loading
            do {
                if let api {
                    peopleList = try await api.getPeople()
                    nextURL = api.nextURL
                    state = .loaded
                }
            } catch {
                state = .error
            }
        }
    }
    
    func fetchNextPage() async {
        guard let nextPage = nextURL else  { return }
        state = .loading
        
        do {
            if let api {
                let response = try await api.getPeopleFromURL(nextPage)
                peopleList.append(contentsOf: response.results)
                state = .loaded
                
                nextURL = response.next
            }
        } catch {
            state = .error
        }
    }
}
