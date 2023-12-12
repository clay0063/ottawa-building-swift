//
//  Functions.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import Foundation

func searchBuildings(data: [Building], searchName: String) -> [Building] {
    if searchName.isEmpty {
        return data
    } else {
        return data.filter { building in
            building.name.lowercased().contains(searchName.lowercased())
        }
    }
}

func fixURL(_ urlString: String) -> URL? {
    var fixedURLString = urlString

    if !fixedURLString.hasPrefix("http://") && !fixedURLString.hasPrefix("https://") {
        if !fixedURLString.hasPrefix("www.") {
            fixedURLString = "www." + fixedURLString
        }
        fixedURLString = "https://" + fixedURLString
    }

    return URL(string: fixedURLString)
}

func timeFormatter(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    } else {
        return "Error formatting date"
    }
    
}

func mapIcon(category: String) -> String {
    switch category {
    case "Academic Institutions":
        return "mapAcademic"
    case "Business and/or Foundations":
        return "mapBusiness"
    case "Community and/or Care centres":
        return "mapCommunity"
    case "Embassies":
        return "mapEmbassy"
    case "Functional Buildings":
        return "mapFunctional"
    case "Galleries and Theatres":
        return "mapGalleries"
    case "Government buildings":
        return "mapGovernement"
    case "Museums, Archives, and Historic Sites":
        return "mapMuseum"
    case "Other":
        return "mapOther"
    case "Religious buildings":
        return "mapCommunity" //no religious icon?
    case "Sports and Leisure buildings":
        return "mapSports"
    default:
        return "mapOther"
    }
}
