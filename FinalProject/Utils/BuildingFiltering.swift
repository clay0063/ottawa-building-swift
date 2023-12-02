//
//  BuildingFiltering.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-02.
//

import Foundation

class BuildingFiltering {
    func filterData(buildings: [Building], selectedFeature: String, selectedCategory: String, selectedSortBy: String) -> [Building] {
        var filteredList = buildings
        
        //FILTER FEATURE
        
        //FILTER CATEGORY
        if selectedCategory != "Placeholder" {
            filteredList = filteredList.filter { building in
                building.category == selectedCategory }
        }
        
        
        //SORT BY
        switch selectedSortBy {
        case "A-Z":
            return filteredList.sorted(by: {$0.name < $1.name})
        case "Z-A":
            return filteredList.sorted(by: {$0.name > $1.name})
        case "Distance":
            return filteredList
        default:
            return filteredList
        }
        
    }
}
