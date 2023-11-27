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
