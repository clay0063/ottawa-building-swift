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
            VStack(alignment: .leading) {
                Text("Sort By")
                Picker("Sort by", selection: $selectedSortBy) {
                    ForEach(sortOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.bottom)
            
            Divider()
            
            VStack(alignment: .leading) {
                
                Text("Building Category")
                Picker("Categories", selection: $selectedCategory) {
                    if selectedCategory == "Placeholder" {
                        Text("Pick Category").tag("Placeholder")
                    }
                    ForEach(sortCategories, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(InlinePickerStyle())
                
            }
            .padding(.vertical)
            
            Divider()
            
            VStack {
                
                Text("Filter:")
                Grid(alignment: .bottomLeading,
                horizontalSpacing: 40,
                verticalSpacing: 10) {
                    ForEach(filtering.listOfFeatures, id: \.name) { feature in
                        Button(action: {
                            toggleCategory(feature.name)
                        }) {
                            
                            GridRow {
                                filtering.featureIcons[feature.name]!
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                    .opacity(selectedFeatures.contains(feature.name) ? 1.0 : 0.5)
                                Text(feature.name)
                                    .gridCellAnchor(.bottomLeading)
                                
                            }
                            
                        }
                    }
                }
                
            }
            .padding(.vertical)
            
        }
        .padding()
    }
    
    private func toggleCategory(_ category: String) {
        if selectedFeatures.contains(category) {
            selectedFeatures.remove(category)
        } else {
            selectedFeatures.insert(category)
        }
    }
}
