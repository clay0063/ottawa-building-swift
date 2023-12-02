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
    @State private var position: MapCameraPosition = .automatic
    @State private var selectedItem: Int?
    @State private var isSheetPresented = false
    
    private var selectedPlace: Building? {
        if let selectedItem {
            return listData.first(where: { $0.id.hashValue == selectedItem.hashValue })
        }
        return nil
    }
    
    var body: some View {
        Map(position: $position, selection: $selectedItem) {
            ForEach(listData, id: \.buildingId) { building in
                Marker(
                    building.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: building.latitude,
                        longitude: building.longitude)
                ).tag(building.id)
            }
            //systemImage
            
        }
        .onChange(of: selectedItem) {
            isSheetPresented.toggle()
            print(isSheetPresented)
        }
        .safeAreaInset(edge: .bottom) {
            if let selectedPlace {
                NavigationView{
                    //ADD close button
                    VStack {
                        Text(selectedPlace.name)
                        Text(selectedPlace.address)
                    }
                    
                }
                .frame(height: 128.0)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding([.top, .horizontal])
                .background(.white)
            }
        }
        .sheet(isPresented: $isSheetPresented, content: {
            if let selectedPlace {
                BuildingDetailView(data: selectedPlace)
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(25)
            }
            
        })
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

