//
//  MapView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var vm: BuildingViewModel
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
            return vm.displayList.first(where: { $0.id.hashValue == selectedItem.hashValue })
        }
        return nil
    }
    
    var body: some View {
        var filteredData: [Building] {
            return filtering.filterData(buildings: vm.displayList, selectedFeatures: selectedFeatures, selectedCategory: selectedCategory, selectedSortBy: selectedSortBy, lm: lm)
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
                MapFilterButton(isFilterSheetPresented: $isFilterSheetPresented)
            }
            
        }
        .safeAreaInset(edge: .bottom) {
            if let selectedPlace {
                //ADD close button
                VStack(alignment: .leading) {
                    HStack {
                        SavedButton(data: selectedPlace).padding(.trailing, 25.0)
                        if let websiteURL = fixURL(selectedPlace.website) {
                            ShareLink(Text(""), item: websiteURL).foregroundStyle(Color(red: 0.459, green: 0.459, blue: 0.459))
                        }
                        Spacer()
                        Button {
                            isSheetPresented = true
                        } label: {
                            ZStack {
                                Text("View More")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(
                                        Capsule()
                                            .foregroundColor(.white.opacity(0.85))
                                            .shadow(color: .gray.opacity(0.5), radius: 5)
                                    )
                            }
                            
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(selectedPlace.name)
                                .font(.headline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, 2.0)
                            HStack {
                                Text(selectedPlace.address)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                LocationFromYou(data: selectedPlace, lm: lm)
                            }
                            .foregroundStyle(.gray)
                            
                            
                        }
                    }
                    
                    
                }
                .padding()
                .frame(height: 128.0)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                
                
            }
        }
        .sheet(isPresented: $isSheetPresented, onDismiss: {isSheetPresented = false}, content: {
            if let selectedPlace {
                BuildingDetailView(data: selectedPlace)
                //                    .presentationBackground(.thinMaterial)
                    .presentationDetents([.large])
                    .presentationCornerRadius(25)
            }
            
        })
        .sheet(isPresented: $isFilterSheetPresented) {
            FilterSheetMap(selectedCategory: $selectedCategory, selectedFeatures: $selectedFeatures)
        }
        .mapControls(){
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
    }
}

struct MapFilterButton: View {
    @Binding var isFilterSheetPresented: Bool
    var body: some View {
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
