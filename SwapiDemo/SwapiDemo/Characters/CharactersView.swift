//
//  CharactersView.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 24/12/2024.
//

import SwiftUI

struct CharactersView: View {
    @Environment(CharactersViewModel.self) private var charactersViewModel: CharactersViewModel
    @State private var selectedCharacter: People? = nil
    
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
                            ForEach(characters) { chad in
                                CharacterView(character: chad)
                                    .onTapGesture {
                                        selectedCharacter = chad
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Characters")
            .sheet(item: $selectedCharacter, content: { chad in
                CharacterDetailsView(character: chad)
            })
        }
        .task {
            await charactersViewModel.getData()
        }
    }
}
