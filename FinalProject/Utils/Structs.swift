//
//  Structs.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import Foundation

struct BuildingData: Decodable {
    
    let language: String
    let version: Int
    let year: Int
    let buildings: [Building]
}

struct Building: Decodable, Identifiable {
    //decodable decodes json, identifiable ensures instances are unique
    
    enum BuildingKeys: CodingKey {
        case buildingId
        case name
        case isNew
        case address
        case description
        case website
        case category
        case saturdayStart
        case saturdayClose
        case sundayStart
        case sundayClose
        case isShuttle
        case isPublicWashrooms
        case isAccessible
        case isFreeParking
        case isBikeParking
        case isPaidParking
        case isFamilyFriendly
        case image
        case isGuidedTour
        case isOCTranspoNearby
        case imageDescription
        case latitude
        case longitude
        case categoryId
        case isOpenSaturday
        case isOpenSunday
    }
    
    var id: Int { buildingId }
    let buildingId: Int
    let name: String
    let isNew: Bool
    let address: String
    let description: String
    let website: String
    let category: String
    let saturdayStart: String
    let saturdayClose: String
    let sundayStart: String
    let sundayClose: String
    let isShuttle: Bool
    let isPublicWashrooms: Bool
    let isAccessible: Bool
    let isFreeParking: Bool
    let isBikeParking: Bool
    let isPaidParking: Bool
    let isFamilyFriendly: Bool
    let image: String
    let isGuidedTour: Bool
    let isOCTranspoNearby: Bool
    let imageDescription: String
    let latitude: Double
    let longitude: Double
    let categoryId: Int
    let isOpenSaturday: Bool
    let isOpenSunday: Bool
    
}
