//
//  ContentView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import SwiftUI


struct ContentView: View {
    @StateObject var jsonFetch = JSONFetch()
    @State private var savedList = [Building]()
    @State private var selectedTab = 0
    
    var body: some View {
        let listEN = jsonFetch.buildingDataEN
        //        let listFR = jsonFetch.buildingDataFR
        TabView(selection: $selectedTab) {
            BuildingListView(listData: listEN, savedList: $savedList)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            MapView(listData: listEN, savedList: $savedList)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag(1)
            SavedView(dataList: listEN, savedList: $savedList)
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





//KNOWN BUGS:
//Safari view opens with padding around it
//  Attempted fixes:
//      -Adding ignore safe area inset
//  Most likely explanation:
//      -It's opening with a navlink, so it has the previous navstack padding around it

//Un-faving on Save screen boots back to home
//  Attempted fixes:
//      -Going based on list index instead of list item (made things more unstable)
//  Most likely explanation:
//      -Editing the list causes the UI to refresh, which sends back to home fsr
//  Next step:
//      -Make two lists - a copy of the saved list ???
