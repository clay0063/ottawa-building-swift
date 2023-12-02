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
    
    var body: some View {
        Map() {
            ForEach(listData) { building in
                Marker(building.name, coordinate: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude))
            }
            
            //systemImage
            
        }.mapControls(){
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
    }
}

#Preview {
    ContentView()
}
