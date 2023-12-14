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
            
            DetailsFeaturesView(data: data)
            Divider()
            //                DetailsMapView(data: data)
            
        }
        .padding(.vertical, 0)
        .padding(.horizontal, 10)
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

