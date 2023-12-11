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
    
    let featureIcons: [String: Image] = [
        "Shuttle": Image("shuttle"),
        "Public Washrooms": Image("washroom"),
        "Accessible": Image("accessibility"),
        "Free Parking": Image("freeParking"),
        "Bike Parking": Image("bikeracks"),
        "Paid Parking": Image("paidParking"),
        "Guided Tour": Image("guidedTour"),
        "Family Friendly": Image("familyFriendly"),
        "OC Transpo": Image("ocTranspo"),
        "Open Saturday": Image("saturdayEnglish"),
        "Open Sunday": Image("sundayEnglish"),
    ]
    
    
    
    
    func filterData(buildings: [Building], selectedFeatures: Set<String>, selectedCategory: String, selectedSortBy: String, lm: LocationManager) -> [Building] {
        var filteredList = buildings
        //FILTER FEATURE
        filteredList = filteredList.filter { item in
            selectedFeatures.isEmpty || listOfFeatures.allSatisfy { feature in
                let featureValue = item[keyPath: feature.keyPath]
                return (!selectedFeatures.contains(feature.name) || featureValue)
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
            return filteredList.sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
        case "Z-A":
            return filteredList.sorted(by: {$0.name.lowercased() > $1.name.lowercased()})
        case "Distance":
            guard lm.hasPermission else {
                    return filteredList
                }
            
            let distanceSort = filteredList.sorted(by: {
                let userLat = (lm.userLocation != nil) ? lm.userLocation!.coordinate.latitude : 0
                let userLong = (lm.userLocation != nil) ? lm.userLocation!.coordinate.longitude : 0
                
                let distance1 = lm.findDistanceFromUser(userLat: userLat, userLong: userLong, buildingLat: $0.latitude, buildingLong: $0.longitude)
                let distance2 = lm.findDistanceFromUser(userLat: userLat, userLong: userLong, buildingLat: $1.latitude, buildingLong: $1.longitude)
                return distance1 < distance2
            })
            return distanceSort
            
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

