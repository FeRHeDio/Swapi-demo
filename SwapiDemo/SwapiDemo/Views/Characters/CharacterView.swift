//
//  CharacterView.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 26/12/2024.
//

import SwiftUI

struct CharacterView: View {
    let character: People
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(character.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .frame(width: 180)
            
            HStack {
                Text(character.name)
                    .font(.caption)
                    .bold()
                
                Spacer()
                
                Text(character.id)
                    .font(.caption)
                    .bold()
            }
            .padding()
            .frame(width: 180, alignment: .leading)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
        }
        .shadow(radius: 3)
    }
}

#Preview {
    CharacterView(
        character: People(
            uid: "1",
            name: "Luke Skywalker",
            url: "https://www.swapi.tech/api/people/1"
        )
    )
}
