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
        if selectedFeature != "Clear Features" && selectedFeature != "Placeholder" {
            filteredList = filteredList.filter { building in
                    switch selectedFeature {
                    case "isShuttle":
                        return building.isShuttle
                    case "isPublicWashrooms":
                        return building.isPublicWashrooms
                    case "isAccessible":
                        return building.isFreeParking
                    case "isFreeParking":
                        return building.isFreeParking
                    case "isBikeParking":
                        return building.isBikeParking
                    case "isPaidParking":
                        return building.isPaidParking
                    case "isGuidedTour":
                        return building.isGuidedTour
                    case "isFamilyFriendly":
                        return building.isFamilyFriendly
                    case "isOCTranspoNearby":
                        return building.isOCTranspoNearby
                    case "isOpenSaturday":
                        return building.isOpenSaturday
                    case "isOpenSunday":
                        return building.isOpenSunday
                    default:
                        return false
                    }
                }
        }
        
        //FILTER CATEGORY
        if selectedCategory != "All Categories" && selectedCategory != "Placeholder" {
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
