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
            if !savedList.contains(where: { fav in
                //check if favorites does contains this country
                fav.buildingId == data.buildingId
            }) {
                //adds it to fav array if not
                savedList.append(data)
            } else {
                if let index = savedList.firstIndex(where: { fav in
                    //checks if & WHERE country is in favs
                    fav.buildingId == data.buildingId
                }) {
                    //removes it from favs
                    savedList.remove(at: index)
                }
            }
        } label: {
            Label(savedList.contains(where: { fav in
                fav.buildingId == data.buildingId
            }) ? "Saved!" : "Save Building", systemImage: "star")
            .padding()
            .foregroundStyle(.black)
            .background(.yellow)
        }
    }
}
