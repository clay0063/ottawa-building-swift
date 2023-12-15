//
//  BuildingViewModel.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-15.
//

import Foundation
import Firebase
import Network

class BuildingViewModel: ObservableObject {
    
    @Published var buildingDataEN = [Building]()
    @Published var buildingDataFR = [Building]()
    @Published var displayList = [Building]()
    @Published var savedList = [Building]()
    private let submissionRef = Firestore.firestore().collection("Buildings")
    
    @Published var currentLanguage = "en"
    @Published var isLoading = false
    
    let networkMonitor = NWPathMonitor()
    @Published var isConnected = true
    
    let categoriesListEN = [
        "Academic Institutions",
        "Business and/or Foundations",
        "Community and/or Care centres",
        "Embassies",
        "Functional Buildings",
        "Galleries and Theatres",
        "Government buildings",
        "Museums, Archives, and Historic Sites",
        "Other",
        "Religious buildings",
        "Sports and Leisure buildings"
    ]
    
    let categoriesListFR = [
        "Ambassades",
        "Autres",
        "Centres communautaires/de soins",
        "Entreprises/Fondations",
        "Galeries et théâtres",
        "Musées, archives et lieux historiques",
        "Édifices de sports et loisirs",
        "Édifices gouvernementaux",
        "Édifices religieux",
        "Édifices techniques",
        "Édifices d’enseignement"
    ]
    
    init() {
        loadData()
        checkInternetConnection()
    }
    
    func loadData() {
        isLoading = true
        guard let url = Bundle.main.url(forResource: "buildings", withExtension: "json") else {
            print("Json file not found")
            isLoading = false
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
            updateCurrentList()
        } catch {
            print("Error loading data: \(error)")
        }
    }
    
    func toggleSavedStatus(for building: Building) {
        if let index = savedList.firstIndex(where: { fav in
            fav.buildingId == building.buildingId
        }) {
            savedList.remove(at: index)
        } else {
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
        isLoading = false
    }
    
    func toggleLanguage() {
        isLoading = true
        if currentLanguage == "en" { currentLanguage = "fr" } else { currentLanguage = "en" }
        updateCurrentList()
    }
    
    //function to check internet connection
    //based on this https://www.danijelavrzan.com/posts/2022/11/network-connection-alert-swiftui/
    func checkInternetConnection() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
                }
        networkMonitor.start(queue: DispatchQueue(label: "Monitor"))
    }
}
