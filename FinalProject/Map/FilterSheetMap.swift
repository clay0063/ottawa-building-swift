//
//  FilterSheetMap.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-11.
//

import SwiftUI

struct FilterSheetMap: View {
    @EnvironmentObject var vm: BuildingViewModel
    @Binding var selectedCategory: String
    @Binding var selectedFeatures: Set<String>
    
    
    var sortCategories: [String] {
        let categories = Set(vm.displayList.map {$0.category})
        return ["All Categories"] + Array(categories).sorted()
    }
    let sortOptions = ["A-Z", "Z-A", "Distance"]
    
    let filtering = BuildingFiltering()
    
    var body: some View {
        ScrollView {
            
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
            
            VStack(alignment: .leading) {
                
                Text("Filter:")
                VStack{
                    ForEach(filtering.listOfFeatures, id: \.name) { feature in
                        Button(action: {
                            toggleCategory(feature.name)
                        }) {
                            
                            HStack {
                                HStack {
                                    filtering.featureIcons[feature.name]!
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                .frame(width:50)
                                
                                VStack(alignment: .leading) {
                                    Text(feature.name)
                                        .gridCellAnchor(.bottomLeading)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.leading, 20)
                                
                                
                                Spacer()
                                
                                if selectedFeatures.contains(feature.name) {
                                    Image(systemName: "checkmark.square.fill")
                                        .gridCellAnchor(.bottomTrailing)
                                        .padding(.leading, 10)
                                        .foregroundStyle(.gray)
                                } else {
                                    Image(systemName: "square")
                                        .gridCellAnchor(.bottomTrailing)
                                        .padding(.leading, 10)
                                        .foregroundStyle(.gray)
                                }
                                
                                    
                                
                            }
                            .frame(height: 25)
                            .frame(maxWidth: .infinity)
                            
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            
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
