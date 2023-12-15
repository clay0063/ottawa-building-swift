//
//  ContentView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var vm: BuildingViewModel
    @ObservedObject var lm = LocationManager()
    @State private var selectedTab = 0
    
    var body: some View {
        if vm.isLoading {
            ProgressView()
        } else {
            TabView(selection: $selectedTab) {
                BuildingListView(lm: lm)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
                MapView(lm: lm)
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
                    .tag(1)
                
                SavedView(lm: lm)
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
}

#Preview {
    ContentView().environmentObject(BuildingViewModel())
}


//Searchable I cannot get the color of either the text or background to change
//Tried changing UI on init, tried tints and accent colours in different places... 
