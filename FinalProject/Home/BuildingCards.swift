//
//  BuildingCards.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct BuildingCards: View {
    let data: Building
    @Binding var savedList: [Building]
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
                    Button {
                        withAnimation {
                            if !savedList.contains(where: { fav in
                                // check if favorites contain this country
                                fav.buildingId == data.buildingId
                            }) {
                                // adds it to fav array if not
                                savedList.append(data)
                            } else {
                                if let index = savedList.firstIndex(where: { fav in
                                    // checks if & WHERE country is in favs
                                    fav.buildingId == data.buildingId
                                }) {
                                    // removes it from favs
                                    savedList.remove(at: index)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: savedList.contains(where: { fav in
                            fav.buildingId == data.buildingId
                        }) ? "heart.fill" : "heart")
                        
                    }
                    if let websiteURL = fixURL(data.website) {
                        ShareLink(Text(""), item: websiteURL)
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
