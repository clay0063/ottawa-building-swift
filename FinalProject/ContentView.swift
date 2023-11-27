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
                    Image(systemName: "heart")
                    Image(systemName: "square.and.arrow.up")
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
                            Spacer()
                            Text("km from you")
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

struct BuildingDetailView: View {
    let data: Building
    var body: some View {
        let imageURL = data.image.replacingOccurrences(of: ".jpg", with: "")
        ScrollView {
            VStack {
                VStack{
                    Text("Main:")
                    Image(imageURL, label: Text("\(data.imageDescription)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                    Text("ID: \(data.id)")
                    Text("Name: \(data.name)")
                    Text("New: \(data.isNew ? "True" : "False")")
                    Text("Description: \(data.description)")
                    Text("Website: \(data.website)")
                    Text("Category: \(data.category)")
                    Text("Latitude: \(data.latitude)")
                    Text("Longitude: \(data.longitude)")
                    Text("Address: \(data.address)")
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




