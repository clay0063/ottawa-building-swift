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
                                BuildingCards(data: building, savedList: $savedList)
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isFilterSheetPresented.toggle()
                        } label: {
                            Image("filterIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .padding(10)
                            
                        }
                    }
                }
                .sheet(isPresented: $isFilterSheetPresented) {
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



