//
//  ContentView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var jsonFetch = JSONFetch()
    
    var body: some View {
        let listEN = jsonFetch.buildingDataEN
//        let listFR = jsonFetch.buildingDataFR
        
        VStack {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach(listEN) { building in
                            NavigationLink(
                                destination: BuildingDetailView(data: building)
                            ) {
                                BuildingCards(data: building)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct BuildingCards: View {
    let data: Building
    var body: some View {
        Text(data.name)
    }
}

struct BuildingDetailView: View {
    let data: Building
    var body: some View {
        ScrollView {
            VStack {
                VStack{
                    Text("Main:")
                    Text("ID: \(data.id)")
                    Text("Name: \(data.name)")
                    Text("New: \(data.isNew ? "True" : "False")")
                    Text("Address: \(data.address)")
                    Text("Description: \(data.description)")
                    Text("Website: \(data.website)")
                    Text("Category: \(data.category)")
                    Text("Image: \(data.image)")
                    Text("Image Desc: \(data.imageDescription)")
                    Text("Latitude: \(data.latitude)")
                    Text("Longitude: \(data.longitude)")
                    Text("Category ID: \(data.categoryId)")
                }.padding(.bottom)
                
                
                VStack {
                    Text("Hours:")
                    Text("Open Sat: \(data.isOpenSaturday ? "True" : "False")")
                    Text("Open Sun: \(data.isOpenSunday ? "True" : "False")")
                    Text("Sat Start: \(data.saturdayStart)")
                    Text("Sat Close: \(data.saturdayClose)")
                    Text("Sun Start: \(data.sundayStart)")
                    Text("Sun Close: \(data.sundayClose)")
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
                }.padding(.bottom)
                
            }.padding()
        }
    }
}




