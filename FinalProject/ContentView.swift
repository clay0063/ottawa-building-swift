//
//  ContentView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var jsonFetch = JSONFetch()
    @State private var selectedTab = 0
    
    var body: some View {
        let listEN = jsonFetch.buildingDataEN
        //        let listFR = jsonFetch.buildingDataFR
        TabView(selection: $selectedTab) {
            BuildingListView(listData: listEN)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag(1)
            SavedView()
                .tabItem {
                    Image(systemName: "suit.heart")
                    Text("Saved")
                }
            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
        }
        
    }
}

#Preview {
    ContentView()
}



