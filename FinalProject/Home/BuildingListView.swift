//
//  BuildingListView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct BuildingListView: View {
    var listData: [Building]
    @Binding var savedList: [Building]
    @State private var searchName = ""
    @State private var selectedFeatures = "Placeholder"
    @State private var selectedCategory = "Placeholder"
    @State private var selectedSortBy = "Placeholder"
    @State var filtering = BuildingFiltering()
    
    var filteredData: [Building] {
        return filtering.filterData(buildings: listData, selectedFeature: selectedFeatures, selectedCategory: selectedCategory, selectedSortBy: selectedSortBy)
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                //filter stuff goes here
                FilterPicker(listData: listData, selectedFeatures: $selectedFeatures, selectedCategory: $selectedCategory, selectedSortBy: $selectedSortBy)
                ScrollView {
                    LazyVStack {
                        ForEach(filteredData.filter { building in
                            return searchName.isEmpty || building.name.lowercased().contains(searchName.lowercased())
                        }) { building in
                            NavigationLink(
                                destination: BuildingDetailView(data: building, savedList: $savedList, dataList: listData)
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


struct FilterPicker: View {
    var listData: [Building]
    @Binding var selectedFeatures: String
    @Binding var selectedCategory: String
    @Binding var selectedSortBy: String
    
    let sortFeatures = [ "Clear Features",
        "isShuttle", "isPublicWashrooms", "isAccessible", "isFreeParking",
        "isBikeParking", "isPaidParking", "isGuidedTour", "isFamilyFriendly",
        "isOCTranspoNearby", "isOpenSaturday", "isOpenSunday"
    ]
    var sortCategories: [String] {
        let categories = Set(listData.map {$0.category})
        return ["All Categories"] + Array(categories).sorted()
    }
    let sortOptions = ["A-Z", "Z-A", "Distance"]
    
    var body: some View {
        VStack {
            Picker("Features", selection: $selectedFeatures) {
                if selectedFeatures == "Placeholder" {
                    Text("Pick Feature").tag("Placeholder")
                }
                ForEach(sortFeatures, id: \.self) { option in
                    Text(option)
                }
            }.pickerStyle(MenuPickerStyle())
            
            Picker("Categories", selection: $selectedCategory) {
                if selectedCategory == "Placeholder" {
                    Text("Pick Category").tag("Placeholder")
                }
                ForEach(sortCategories, id: \.self) { option in
                    Text(option)
                }
            }.pickerStyle(MenuPickerStyle())
            
            Picker("Sort by", selection: $selectedSortBy) {
                if selectedSortBy == "Placeholder" {
                    Text("Sort by...").tag("Placeholder")
                }
                ForEach(sortOptions, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        
    }
}
