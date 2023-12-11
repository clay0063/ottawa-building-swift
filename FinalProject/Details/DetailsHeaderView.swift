//
//  DetailsHeaderView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-10.
//

import SwiftUI

struct DetailsHeaderView: View {
    var data: Building
    @Binding var savedList: [Building]
    let categoryManager = CategoryManager()
    var body: some View {
        let imageURL = data.image.replacingOccurrences(of: ".jpg", with: "")
        VStack {
            VStack {
                Image(imageURL, label: Text("\(data.imageDescription)"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(0)
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        SavedButton(data: data, savedList: $savedList).padding(.trailing, 25.0)
                        if let websiteURL = fixURL(data.website) {
                            ShareLink(Text(""), item: websiteURL)
                                .foregroundStyle(Color(red: 0.459, green: 0.459, blue: 0.459))
                        }
                    }
                    HStack {
                        Text(data.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 2.0)
                    }
                    HStack(alignment: .center) {
                        if let categoryWithIcon = categoryManager.categoriesWithIcons.first(where: { $0.category == data.category }) {
                            
                            categoryWithIcon.icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                            
                            Text(data.category)
                                .foregroundStyle(Color(red: 0.459, green: 0.459, blue: 0.459))
                        }
                    }
                    
                    
                }
                
                VStack {
                    Image("newBuilding")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                        .rotationEffect(.degrees(-25))
                        .opacity(data.isNew ? 1 : 0)
                }.padding(.leading, 20)
            }.padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity)
    }
}
