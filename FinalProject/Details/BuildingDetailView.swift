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
    
    var body: some View {
        
        ScrollView {
            DetailsHeaderView(data: data, savedList: $savedList)
            Divider()
            
            DetailsHoursView(data: data)
            Divider()
            
            DetailsDescriptionView(data: data)
            Divider()
            //                DetailsFeaturesView(data: data)
            //                DetailsMapView(data: data)
            
        }
        .frame(maxHeight: .infinity)
    }
}



#Preview {
    ContentView()
}



struct DetailsHoursView: View {
    var data: Building
    var body: some View {
        VStack(alignment: .leading) {
            Text("Weekend Hours")
                .font(.headline)
                .padding(.bottom)
            Text("Saturday: \(data.isOpenSaturday ? "\(timeFormatter(data.saturdayStart)) - \(timeFormatter(data.saturdayClose))" : "Closed")")
            Text("Sunday: \(data.isOpenSunday ? "\(timeFormatter(data.sundayStart)) - \(timeFormatter(data.sundayClose))" : "Closed")")
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct DetailsDescriptionView: View {
    var data: Building
    @State private var isFullDesc = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.headline)
                .padding(.bottom)
            Text(data.description)
                .multilineTextAlignment(.leading)
                .lineLimit(isFullDesc ? nil : 5)
            HStack {
                Spacer()
                Button(action: {
                    isFullDesc.toggle()
                }, label: {
                    Text(isFullDesc ? "Show Less" : "Read More")
                })
            }.padding(.top, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct DetailsFeaturesView: View {
    var data: Building
    let filtering = BuildingFiltering()
    var body: some View {
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
    }
}

struct DetailsMapView: View {
    var data: Building
    var body: some View {
        VStack {
            Text("Latitude: \(data.latitude)")
            Text("Longitude: \(data.longitude)")
            Text("Address: \(data.address)")
        }
    }
}

