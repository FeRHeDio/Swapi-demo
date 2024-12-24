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
        ScrollView {
            VStack {
                ForEach(charactersViewModel.peopleList, id: \.uid) {
                    Text($0.name)
                }
            }
        }
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        await charactersViewModel.getData()
    }
}
//
//#Preview {
//    CharactersView(charactersViewModel: CharactersViewModel(api: API()))
//}
