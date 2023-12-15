//
//  BuildingViewModel.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-15.
//

import Foundation

class BuildingViewModel: ObservableObject {
    @Published var buildingDataEN = [Building]()
    @Published var buildingDataFR = [Building]()
    @Published var savedList = [Building]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "buildings", withExtension: "json") else {
            print("Json file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let buildingDataArray = try JSONDecoder().decode([BuildingData].self, from: data)
            
            for buildingData in buildingDataArray {
                let buildingList = buildingData.buildings
                
                switch buildingData.language {
                case "en":
                    self.buildingDataEN.append(contentsOf: buildingList)
                case "fr":
                    self.buildingDataFR.append(contentsOf: buildingList)
                default:
                    break
                }
            }
        } catch {
            print("Error loading data: \(error)")
        }
    }
    
    func toggleSavedStatus(for building: Building) {
        if let index = savedList.firstIndex(where: { fav in
            fav.buildingId == building.buildingId
        }) {
            // Building is already in the saved list, remove it
            savedList.remove(at: index)
        } else {
            // Building is not in the saved list, add it
            savedList.append(building)
        }
        
    }
    
}
