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
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text(character.name)
                    .font(.headline)
                    .bold()
                Text(character.url)
                    .font(.footnote)
            }
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 32)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1)
                .foregroundColor(.gray)
            HStack {
                Spacer()
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
            }
            .padding(.trailing, 24)
            .opacity(0.3)
        }
    }
}

#Preview {
    CharacterView(
        character: People(
            uid: "1",
            name: "Luke Skywalker",
            url: "www.something",
            imageURL: nil
        )
    )
}
