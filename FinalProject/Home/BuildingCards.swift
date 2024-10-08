//
//  BuildingCards.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct BuildingCards: View {
    let data: Building
    var lm: LocationManager
    
    var body: some View {
        let imageURL = data.image.replacingOccurrences(of: ".jpg", with: "")
        VStack {
            VStack {
                Image(imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 300)
                    .frame(maxWidth: 500)
            }
            VStack {
                HStack {
                    SavedButton(data: data).padding(.trailing, 25.0)
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
                            LocationFromYou(data: data, lm: lm)
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
    var lm: LocationManager
    
    var body: some View {
        
        if lm.hasPermission {
            let distanceFromYou = lm.findDistanceFromUser(
                //if we have permission, it shouldnt be nil, but error handle to be safe
                userLat: (lm.userLocation != nil) ? lm.userLocation!.coordinate.latitude : 0,
                userLong: (lm.userLocation != nil) ? lm.userLocation!.coordinate.longitude : 0,
                buildingLat: data.latitude,
                buildingLong: data.longitude
            )
            
            Text("\(String(format:"%.2f", distanceFromYou)) km away")
        }
        
    }
}
