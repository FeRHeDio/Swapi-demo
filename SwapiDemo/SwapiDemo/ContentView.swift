//
//  ContentView.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 23/12/2024.
//

import SwiftUI

struct ContentView: View {
    let session = URLSession.shared
    
    var body: some View {
        TabView {
            CharactersView(charactersViewModel: CharactersViewModel(api: API(session: session)))
                .tabItem {
                    Label(
                        title: { Text("Characters") },
                        icon: { Image(systemName: "person.3") }
                    )
                }
            
            Text("Movies")
                .tabItem {
                    Label(
                        title: { Text("Movies") },
                        icon: { Image(systemName: "popcorn") }
                    )
                }
        }
    }
}

#Preview {
    ContentView()
}
