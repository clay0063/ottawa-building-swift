//
//  MapView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI
import MapKit

struct MapView: View {
    var listData: [Building]
    @Binding var savedList: [Building]
    var lm: LocationManager
    @State private var position: MapCameraPosition = .automatic
    @State private var selectedItem: Int?
    @State private var isSheetPresented = false
    @State private var isFilterSheetPresented = false
    @State private var searchName = ""
    @State private var selectedSortBy = "A-Z"
    @State private var selectedCategory = "Placeholder"
    let filtering = BuildingFiltering()
    @State private var selectedFeatures: Set<String> = []
    
    
    
    private var selectedPlace: Building? {
        if let selectedItem {
            return listData.first(where: { $0.id.hashValue == selectedItem.hashValue })
        }
        return nil
    }
    
    var body: some View {
        var filteredData: [Building] {
            return filtering.filterData(buildings: listData, selectedFeatures: selectedFeatures, selectedCategory: selectedCategory, selectedSortBy: selectedSortBy, lm: lm)
        }
        
        Map(position: $position, selection: $selectedItem) {
            ForEach(filteredData, id: \.buildingId) { building in
                Annotation(
                    building.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: building.latitude,
                        longitude: building.longitude)
                ) {
                    ZStack {
                        Image(mapIcon(category: building.category))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                    }
                }
                .tag(building.id)
            }
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Spacer()
                HStack {
                    Button {
                        isFilterSheetPresented.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.white.opacity(0.85))
                                .shadow(color: .gray.opacity(0.5), radius: 5)
                            
                            Image("filterIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.0)
                        }
                        
                    }
                    
                }
                .padding(.trailing, 5)
            }
            
        }
        .safeAreaInset(edge: .bottom) {
            if let selectedPlace {
                //ADD close button
                VStack {
                    Text(selectedPlace.name)
                    Text(selectedPlace.address)
                    Button("View more") {
                        isSheetPresented = true
                    }
                }
                .frame(height: 128.0)
                .frame(maxWidth: .infinity)
                .padding([.top, .horizontal])
                .background(.thinMaterial)
            }
        }
        .sheet(isPresented: $isSheetPresented, onDismiss: {isSheetPresented = false}, content: {
            if let selectedPlace {
                BuildingDetailView(data: selectedPlace, savedList: $savedList, dataList: listData)
                //                    .presentationBackground(.thinMaterial)
                    .presentationDetents([.large])
                    .presentationCornerRadius(25)
            }
            
        })
        .sheet(isPresented: $isFilterSheetPresented) {
            FilterSheetMap(listData: listData, selectedCategory: $selectedCategory, selectedFeatures: $selectedFeatures)
        }
        .mapControls(){
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
    }
}

#Preview {
    ContentView()
}

struct Place: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
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
        return "mapGovernment"
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
