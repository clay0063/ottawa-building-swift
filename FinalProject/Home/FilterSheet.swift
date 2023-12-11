//
//  FilterSheet.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-10.
//

import SwiftUI

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
                    HStack {
                        filtering.featureIcons[category.name]!
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .opacity(selectedFeatures.contains(category.name) ? 1.0 : 0.5)
                    }
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
                
                Text("Sort by...")
                Picker("Sort by", selection: $selectedSortBy) {
                    ForEach(sortOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
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
