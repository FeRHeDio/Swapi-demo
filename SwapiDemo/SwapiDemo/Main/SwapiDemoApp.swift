//
//  SwapiDemoApp.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 23/12/2024.
//

import SwiftUI

@main
struct SwapiDemoApp: App {
    let api: API
    let charactersViewModel: CharactersViewModel
    
    init() {
        let session = URLSession.shared
        self.api = API(session: session)
        self.charactersViewModel = CharactersViewModel(api: api)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(charactersViewModel: charactersViewModel)
        }
    }
}
