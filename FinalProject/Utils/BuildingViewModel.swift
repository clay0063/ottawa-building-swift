//
//  BuildingViewModel.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-15.
//

import Foundation
import Firebase

class BuildingViewModel: ObservableObject {
    
    @Published var buildingDataEN = [Building]()
    @Published var buildingDataFR = [Building]()
    @Published var displayList = [Building]()
    @Published var savedList = [Building]()
    private let submissionRef = Firestore.firestore().collection("Buildings")
    
    @Published var currentLanguage = "en"
    
    
    init() {
        loadData()
        updateCurrentList()
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
    
    func submitBuilding(building: Submission){
        let ref = submissionRef.document(building.id)
        
        ref.setData(
            [
                "id": building.id,
                "name": building.name,
                "category": building.category,
                "description": building.description
            ]
        ) {
            error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateCurrentList() {
        switch currentLanguage {
        case "en":
            displayList = buildingDataEN
        case "fr":
            displayList = buildingDataFR
        default:
            break
        }
    }
    
    func toggleLanguage() {
        updateCurrentList()
    }
    
}
