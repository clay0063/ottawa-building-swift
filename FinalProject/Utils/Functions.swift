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
