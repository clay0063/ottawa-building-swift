//
//  DetailsFeaturesView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-10.
//

import SwiftUI

struct DetailsFeaturesView: View {
    var data: Building
    let filtering = BuildingFiltering()
    @State private var isFullDetails = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("Amenities")
                .font(.headline)
                .padding(.bottom)
            VStack(alignment: .leading, spacing: 10.0){
                
                if !isFullDetails {
                    // COLLAPSED VIEW
                    ScrollView(.horizontal) {
                        HStack(alignment: .bottom) {
                            ForEach(filtering.listOfFeatures, id: \.name) { feature in
                                //reads tuple list, connects to key in building, sees if its true
                                let (featureName, keyPath) = feature
                                let isFeatureEnabled = data[keyPath: keyPath]
                                
                                
                                //if its true, it displays it as an icon
                                if isFeatureEnabled {
                                    
                                    GridRow{
                                        filtering.featureIcons[featureName]?
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 35, height: 35)
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                } else {
                    //FULL VIEW
                    Grid(alignment: .bottomLeading,
                         horizontalSpacing: 40,
                         verticalSpacing: 10) {
                        ForEach(filtering.listOfFeatures, id: \.name) { feature in
                            //reads tuple list, connects to key in building, sees if its true
                            let (featureName, keyPath) = feature
                            let isFeatureEnabled = data[keyPath: keyPath]
                            
                            
                            //if its true, it displays it as an icon
                            if isFeatureEnabled {
                                
                                GridRow{
                                    filtering.featureIcons[featureName]?
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35)
                                        .gridCellAnchor(.center)
                                    
                                    Text(featureName)
                                        .gridCellAnchor(.bottomLeading)
                                }
                                
                            }
                        }
                    }
                }
                
                
                HStack {
                    Spacer()
                    Button(action: {
                        isFullDetails.toggle()
                    }, label: {
                        Text(isFullDetails ? "Collapse" : "View Details")
                    })
                }
                .padding(.top, 2)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
