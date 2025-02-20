//
//  CharacterDetailsView.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 27/12/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    let character: People
    
    var body: some View {
        Text("Hi, my name is: \(character.name)")
        Text("My id is: \(character.id)")
        
    }
}
