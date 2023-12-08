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
    //    @State private var selectedFeatures = "Placeholder"
    @State private var selectedCategory = "Placeholder"
    @State private var selectedSortBy = "Placeholder"
    let filtering = BuildingFiltering()
    @State private var selectedFeatures: Set<String> = []
    @State private var isFilterSheetPresented = false
    
    
    
    var filteredData: [Building] {
        return filtering.filterData(buildings: listData, selectedFeatures: selectedFeatures, selectedCategory: selectedCategory, selectedSortBy: selectedSortBy)
    }
    
    var body: some View {
        VStack {
            NavigationStack {
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
                .navigationTitle("Test")
                .navigationBarItems(trailing:  Button("Filter") {
                    isFilterSheetPresented.toggle()
                }
                ).sheet(isPresented: $isFilterSheetPresented) {
                    FilterSheet(listData: listData, selectedCategory: $selectedCategory, selectedSortBy: $selectedSortBy, selectedFeatures: $selectedFeatures)
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


struct FilterSheet: View {
    
    var listData: [Building]
    @Binding var selectedCategory: String
    @Binding var selectedSortBy: String
    @Binding var selectedFeatures: Set<String>
    
    
    var sortCategories: [String] {
        let categories = Set(listData.map {$0.category})
        return ["All Categories"] + Array(categories).sorted()
    }
    let sortOptions = ["A-Z", "Z-A", "Distance"]
    
    let filtering = BuildingFiltering()
    
    var body: some View {
        VStack {
            Text("Filter:")
            ForEach(filtering.listOfFeatures, id: \.name) { category in
                Button(action: {
                    toggleCategory(category.name)
                }) {
                    Text(category.name)
                        .fontWeight(selectedFeatures.contains(category.name) ? .bold : .regular)
                }
            }
            
            VStack {
                
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
    
    private func toggleCategory(_ category: String) {
        if selectedFeatures.contains(category) {
            selectedFeatures.remove(category)
        } else {
            selectedFeatures.insert(category)
        }
    }
}
