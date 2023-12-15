//
//  BuildingListView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct BuildingListView: View {
    var lm: LocationManager
    @EnvironmentObject var vm: BuildingViewModel
    @State private var searchName = ""
    @State private var selectedCategory = "Placeholder"
    @State private var selectedSortBy = "A-Z"
    let filtering = BuildingFiltering()
    @State private var selectedFeatures: Set<String> = []
    @State private var isFilterSheetPresented = false
    
    var filteredData: [Building] {
        return filtering.filterData(buildings: vm.displayList, selectedFeatures: selectedFeatures, selectedCategory: selectedCategory, selectedSortBy: selectedSortBy, lm: lm)
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(filteredData.filter { building in
                        return searchName.isEmpty || building.name.lowercased().contains(searchName.lowercased())
                    }) { building in
                        NavigationLink(
                            destination: BuildingDetailView(data: building)
                        ) {
                            BuildingCards(data: building, lm: lm)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(alignment: .center) {
                        Image("ic_logo_new")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                        Text("Building List")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.leading, 5)
                    }
                    
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isFilterSheetPresented.toggle()
                    } label: {
                        Image("filterIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                            .padding(10)
                            .foregroundStyle(.white)
                        
                    }
                    
                }
            }
            .toolbarBackground(Color.customDarkBlue, for: .navigationBar)
            .toolbarBackground(.visible)
            .sheet(isPresented: $isFilterSheetPresented) {
                FilterSheet(selectedCategory: $selectedCategory, selectedSortBy: $selectedSortBy, selectedFeatures: $selectedFeatures)
            }
            .onAppear {
                selectedCategory = "Placeholder"
                selectedFeatures = []
                //prevents issues when switching languages while something is selected
            }
            
        }
        .searchable(
            text: $searchName,
            prompt: "Search..."
        )
        
        
        
    }
}



#Preview {
    ContentView().environmentObject(BuildingViewModel())
}



