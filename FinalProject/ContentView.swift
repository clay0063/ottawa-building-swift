//
//  ContentView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var viewModel: BuildingViewModel
    @ObservedObject var lm = LocationManager()
    @StateObject var jsonFetch = JSONFetch()
    @State private var selectedTab = 0
    
    var body: some View {
        let listEN = jsonFetch.buildingDataEN
        //        let listFR = jsonFetch.buildingDataFR
        TabView(selection: $selectedTab) {
            BuildingListView(listData: listEN, lm: lm)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
//                .toolbarBackground(Color.customDarkBlue, for: .tabBar)
            
            MapView(listData: listEN, lm: lm)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag(1)
            
            SavedView(dataList: listEN, lm: lm)
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

//Searchable I cannot get the color of either the text or background to change
//Sometimes the save hearts when pressed will not switch to being "filled". They still get added to saved though

