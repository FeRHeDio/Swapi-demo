//
//  CharactersView.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 24/12/2024.
//

import SwiftUI

struct CharactersView: View {
    let charactersViewModel: CharactersViewModel
    
    init(charactersViewModel: CharactersViewModel) {
        self.charactersViewModel = charactersViewModel
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch charactersViewModel.state {
                case .loading:
                    ProgressView()
                case .error:
                    Text("An error ocurred")
                case .loaded(let characters):
                    ScrollView {
                        VStack {
                            ForEach(characters, id: \.uid) {
                                Text($0.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Characters")
        }
        .task {
            await charactersViewModel.getData()
        }
        
    }
}
//
//#Preview {
//    CharactersView(charactersViewModel: CharactersViewModel(api: API()))
//}
