//
//  ContentView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var lm = LocationManager()
    @StateObject var jsonFetch = JSONFetch()
    @State private var savedList = [Building]()
    @State private var selectedTab = 0
    
    var body: some View {
        let listEN = jsonFetch.buildingDataEN
        //        let listFR = jsonFetch.buildingDataFR
        TabView(selection: $selectedTab) {
            BuildingListView(listData: listEN, savedList: $savedList, lm: lm)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
//                .toolbarBackground(Color.customDarkBlue, for: .tabBar)
            
            MapView(listData: listEN, savedList: $savedList, lm: lm)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag(1)
            
            SavedView(dataList: listEN, savedList: $savedList, lm: lm)
                .tabItem {
                    Image(systemName: "suit.heart")
                    Text("Saved")
                }
                .tag(2)
            
            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
                .tag(3)
        }
        
        .tint(Color.customDarkBlue)
        
    }
}

#Preview {
    ContentView()
}





//KNOWN BUGS:
//Safari view opens with padding around it
//  Attempted fixes:
//      -Adding ignore safe area inset
//  Most likely explanation:
//      -It's opening with a navlink, so it has the previous navstack padding around it
