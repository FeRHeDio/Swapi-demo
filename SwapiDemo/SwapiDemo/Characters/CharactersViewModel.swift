//
//  CharactersViewModel.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 24/12/2024.
//

import Foundation

@Observable
class CharactersViewModel {
    var peopleList = [People]()
    let api: API

    init(peopleList: [People] = [People](), api: API) {
        self.peopleList = peopleList
        self.api = api
    }
    
    func getData() async {
        do {
           peopleList = try await api.getPeople()
        } catch let error {
            print("error getting people: \(error.localizedDescription)")
        }
    }
}
