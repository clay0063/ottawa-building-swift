//
//  BuildingListView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct BuildingListView: View {
    var listData: [Building]
    @State private var searchName = ""
    
    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach(searchBuildings(data: listData, searchName: searchName)) { building in
                            NavigationLink(
                                destination: BuildingDetailView(data: building)
                            ) {
                                BuildingCards(data: building)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchName, prompt: "Search...")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
