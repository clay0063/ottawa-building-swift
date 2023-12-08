//
//  BuildingFiltering.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-02.
//

import Foundation
import SwiftUI

class BuildingFiltering {
    let listOfFeatures: [(name: String, keyPath: KeyPath<Building, Bool>)] = [
        ("Shuttle", \.isShuttle),
        ("Public Washrooms", \.isPublicWashrooms),
        ("Accessible", \.isAccessible),
        ("Free Parking", \.isFreeParking),
        ("Bike Parking", \.isBikeParking),
        ("Paid Parking", \.isPaidParking),
        ("Guided Tour", \.isGuidedTour),
        ("Family Friendly", \.isFamilyFriendly),
        ("OC Transpo", \.isOCTranspoNearby),
        ("Open Saturday", \.isOpenSaturday),
        ("Open Sunday", \.isOpenSunday),
    ]
    
    func filterData(buildings: [Building], selectedFeatures: Set<String>, selectedCategory: String, selectedSortBy: String) -> [Building] {
        var filteredList = buildings
        //FILTER FEATURE
        filteredList = filteredList.filter { item in
            selectedFeatures.isEmpty || listOfFeatures.allSatisfy { feature in
                let featureValue = item[keyPath: feature.keyPath]
                return (!selectedFeatures.contains(feature.name) || featureValue)
            }
        }
//        if selectedFeature != "Clear Features" && selectedFeature != "Placeholder" {
//            filteredList = filteredList.filter { building in
//                    switch selectedFeature {
//                    case "isShuttle":
//                        return building.isShuttle
//                    case "isPublicWashrooms":
//                        return building.isPublicWashrooms
//                    case "isAccessible":
//                        return building.isAccessible
//                    case "isFreeParking":
//                        return building.isFreeParking
//                    case "isBikeParking":
//                        return building.isBikeParking
//                    case "isPaidParking":
//                        return building.isPaidParking
//                    case "isGuidedTour":
//                        return building.isGuidedTour
//                    case "isFamilyFriendly":
//                        return building.isFamilyFriendly
//                    case "isOCTranspoNearby":
//                        return building.isOCTranspoNearby
//                    case "isOpenSaturday":
//                        return building.isOpenSaturday
//                    case "isOpenSunday":
//                        return building.isOpenSunday
//                    default:
//                        return false
//                    }
//                }
//        }
        
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


struct FilterData: Identifiable {
    var id = UUID()
    var imageName: String
    var title: String
    var isSelected: Bool = false
}

