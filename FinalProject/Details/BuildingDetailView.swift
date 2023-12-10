//
//  BuildingDetailView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI


struct BuildingDetailView: View {
    let data: Building
    @Binding var savedList: [Building]
    let dataList: [Building]
    let filtering = BuildingFiltering()
    
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
                    SavedButton(data: data, savedList: $savedList)
                }
                
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

                    ForEach(filtering.listOfFeatures, id: \.name) { feature in
                        //reads tuple list, connects to key in building, sees if its true
                        let (featureName, keyPath) = feature
                        let isFeatureEnabled = data[keyPath: keyPath]

                        HStack {
                            //if its true, it displays it as an icon
                            if isFeatureEnabled {
                                filtering.featureIcons[featureName]?
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                            }
                        }
                    }

                    Divider()
                }.padding(.bottom)
                
                
                VStack {
                    Text("Latitude: \(data.latitude)")
                    Text("Longitude: \(data.longitude)")
                    Text("Address: \(data.address)")
                }
                
            }.frame(maxHeight: .infinity)
                .padding()
        }
    }
}


#Preview {
    ContentView()
}
