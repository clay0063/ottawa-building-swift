//
//  SavedButton.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-03.
//

import SwiftUI

struct SavedButton: View {
    var data: Building
    @Binding var savedList: [Building]
    var body: some View {
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
            Image(savedList.contains(where: { fav in
                fav.buildingId == data.buildingId
            }) ? "favoriteGreyFilledIcon" : "favouriteOutlineGray")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height:20)
            
        }
    }
}
