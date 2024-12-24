//
//  ContentView.swift
//  SwapiDemo
//
//  Created by Fernando Putallaz on 23/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CharactersView()
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
            
            Text("Planets")
                .tabItem {
                    Label(
                        title: { Text("Planets") },
                        icon: { Image(systemName: "network") }
                    )
                }
            
            Text("Species")
                .tabItem {
                    Label(
                        title: { Text("Species") },
                        icon: { Image(systemName: "graduationcap.fill") }
                    )
                }
            
            Text("Vehicles")
                .tabItem {
                    Label(
                        title: { Text("Vehicles") },
                        icon: { Image(systemName: "car.rear.road.lane.dashed") }
                    )
                }
        }
    }
}

#Preview {
    ContentView()
}
