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
    let categoryManager = CategoryManager()
    
    var body: some View {
        let imageURL = data.image.replacingOccurrences(of: ".jpg", with: "")
        ScrollView {
            VStack {
                VStack {
                    Image(imageURL, label: Text("\(data.imageDescription)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding(0)
                }
                
                VStack(alignment: .leading){
                    HStack {
                        SavedButton(data: data, savedList: $savedList).padding(.trailing, 25.0)
                        if let websiteURL = fixURL(data.website) {
                            ShareLink(Text(""), item: websiteURL)
                        }
                        Spacer()
                        Text("NEW!").opacity(data.isNew ? 1 : 0)
                    }
                    Text(data.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 2.0)
                    
                    if let categoryWithIcon = categoryManager.categoriesWithIcons.first(where: { $0.category == data.category }) {
                        
                        HStack {
                            categoryWithIcon.icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                            
                            Text(data.category)
                        }
                    }
                    Divider()
                }.padding(.bottom)
                
                //                DetailsHoursView(data: data)
                //                DetailsDescriptionView(data: data)
                //                DetailsFeaturesView(data: data)
                //                DetailsMapView(data: data)
                
            }
            .frame(maxHeight: .infinity)
        }
    }
}


#Preview {
    ContentView()
}

struct DetailsHoursView: View {
    var data: Building
    var body: some View {
        VStack {
            Text("Weekend Hours:")
            Text("Saturdau: \(data.isOpenSaturday ? "\(data.saturdayStart) - \(data.saturdayClose)" : "Closed")")
            Text("Sunday: \(data.isOpenSunday ? "\(data.sundayStart) - \(data.sundayClose)" : "Closed")")
            Divider()
        }.padding(.bottom)
    }
}

struct DetailsDescriptionView: View {
    var data: Building
    var body: some View {
        VStack {
            Text("Description")
            Text("Description: \(data.description)")
            Text("Website: \(data.website)")
            Divider()
        }.padding(.bottom)
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
