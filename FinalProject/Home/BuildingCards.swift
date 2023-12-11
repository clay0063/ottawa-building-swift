//
//  BuildingCards.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct BuildingCards: View {
    let data: Building
    @Binding var savedList: [Building]
    
    var body: some View {
        let imageURL = data.image.replacingOccurrences(of: ".jpg", with: "")
        VStack {
            VStack {
                Image(imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 300)
            }
            VStack {
                HStack {
                    SavedButton(data: data, savedList: $savedList).padding(.trailing, 25.0)
                    if let websiteURL = fixURL(data.website) {
                        ShareLink(Text(""), item: websiteURL).foregroundStyle(Color(red: 0.459, green: 0.459, blue: 0.459))
                    }
                    Spacer()
                    Text("NEW!").opacity(data.isNew ? 1 : 0)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(data.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 2.0)
                        HStack {
                            Text(data.address)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            LocationFromYou(data: data)
                        }
                        .foregroundColor(Color.gray)
                    }
                }
            }.padding()
        }
        .frame(width: 350)
        .foregroundStyle(.black)
        .background(
            Color.white
                .shadow(radius: 2, x: 3, y: 3)
        )
        .padding()
        
    }
}

struct LocationFromYou: View {
    var data: Building
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        
        if locationManager.hasPermission {
            let distanceFromYou = locationManager.findDistanceFromUser(
                //if we have permission, it shouldnt be nil, but error handle to be safe
                userLat: (locationManager.userLocation != nil) ? locationManager.userLocation!.coordinate.latitude : 0,
                userLong: (locationManager.userLocation != nil) ? locationManager.userLocation!.coordinate.longitude : 0,
                buildingLat: data.latitude,
                buildingLong: data.longitude
            )
            
            Text("\(String(format:"%.2f", distanceFromYou)) km from you")
        }
        
    }
}
