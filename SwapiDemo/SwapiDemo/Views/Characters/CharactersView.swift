//
//  CharactersView.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 24/12/2024.
//

import SwiftUI

struct CharactersView: View {
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
                case .loaded:
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(charactersViewModel.peopleList) { chad in
                                CharacterView(character: chad)
                                    .onAppear {
                                        if chad == charactersViewModel.peopleList.last, charactersViewModel.hasMorePages {
                                            Task {
                                                await charactersViewModel.fetchNextPage()
                                            }
                                        }
                                    }
                                    .onTapGesture {
                                        selectedCharacter = chad
                                    }
                                    .padding(.vertical, 8)
                            }
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
        .task {
            await charactersViewModel.getData()
        }
    }
}

#Preview {
    CharactersView(
        charactersViewModel: CharactersViewModel(
            useMockData: true
        )
    )
}
