//
//  CharactersView.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 24/12/2024.
//

import SwiftUI

struct CharactersListView: View {
    let charactersViewModel: CharactersViewModel
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 10)]
    
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
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(characters) { chad in
                                CharacterView(character: chad)
                                    .onTapGesture {
                                        selectedCharacter = chad
                                    }
                                    .padding(.vertical, 8)
                                    .onAppear {
                                        if chad.uid == characters.last?.uid {
                                            charactersViewModel.getPeople()
                                        }
                                    }
                            }
                        }
                        
                        if charactersViewModel.showProgressView {
                            ProgressView()
                        }
                    }
                    .padding(.horizontal, 6)
                }
            }
            .navigationTitle("Characters")
            .sheet(item: $selectedCharacter, content: { chad in
                CharacterDetailsView(character: chad)
            })
        }
    }
}

#Preview {
    CharactersListView(
        charactersViewModel: CharactersViewModel(
            useMockData: true
        )
    )
}
