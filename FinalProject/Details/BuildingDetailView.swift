//
//  BuildingDetailView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct BuildingDetailView: View {
    let data: Building
    var body: some View {
        let imageURL = data.image.replacingOccurrences(of: ".jpg", with: "")
        ScrollView {
            VStack {
                VStack {
                    Image(imageURL, label: Text("\(data.imageDescription)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                }
                
                VStack(alignment: .leading){
                    HStack {
                        Image(systemName: "heart")
                        Image(systemName: "square.and.arrow.up")
                        Spacer()
                        Text("NEW!").opacity(data.isNew ? 1 : 0)
                    }
                    Text(data.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 2.0)
                    Divider()
                    
                }.padding(.bottom)
                
                VStack {
                    Text("Categories:")
                    Text("\(data.category)")
                    Divider()
                }.padding(.bottom)
                
                VStack {
                    Text("Weekend Hours:")
                    Text("Saturdau: \(data.isOpenSaturday ? "\(data.saturdayStart) - \(data.saturdayClose)" : "Closed")")
                    Text("Sunday: \(data.isOpenSunday ? "\(data.sundayStart) - \(data.sundayClose)" : "Closed")")
                    Divider()
                }.padding(.bottom)
                
                VStack {
                    Text("Description")
                    Text("Description: \(data.description)")
                    Text("Website: \(data.website)")
                    Divider()
                }.padding(.bottom)
                
                VStack {
                    Text("Amenities:")
                    Text("Shuttle: \(data.isShuttle ? "True" : "False")")
                    Text("Public Washrooms: \(data.isPublicWashrooms ? "True" : "False")")
                    Text("Accessible: \(data.isAccessible ? "True" : "False")")
                    Text("Free Parking: \(data.isFreeParking ? "True" : "False")")
                    Text("Bike Parking: \(data.isBikeParking ? "True" : "False")")
                    Text("Paid Parking: \(data.isPaidParking ? "True" : "False")")
                    Text("Family Friendly: \(data.isFamilyFriendly ? "True" : "False")")
                    Text("Guided Tour: \(data.isGuidedTour ? "True" : "False")")
                    Text("OC Transpo: \(data.isOCTranspoNearby ? "True" : "False")")
                    Divider()
                }.padding(.bottom)
                
                VStack {
                    Text("Latitude: \(data.latitude)")
                    Text("Longitude: \(data.longitude)")
                    Text("Address: \(data.address)")
                }
                
            }.padding()
        }
    }
}


#Preview {
    ContentView()
}
