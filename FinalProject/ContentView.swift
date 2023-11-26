//
//  ContentView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var jsonFetch = JSONFetch()
    
    var body: some View {
        let listEN = jsonFetch.buildingDataEN
        let listFR = jsonFetch.buildingDataFR
        
        LazyVStack {
            ForEach(listFR) { building in
                Text(building.name)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
