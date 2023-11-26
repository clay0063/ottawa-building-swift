//
//  JSONFetch.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import Foundation


class JSONFetch: ObservableObject {
    @Published var buildingDataEN = [Building]()
    @Published var buildingDataFR = [Building]()
    //observable object will make it update UI when published is updated
    //published here is an array of Country instances, defined above
    
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
}

