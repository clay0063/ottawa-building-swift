//
//  SavedButton.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-03.
//

import SwiftUI

struct SavedButton: View {
    var data: Building
    @EnvironmentObject var vm: BuildingViewModel
    var body: some View {
        Button {
            withAnimation {
                vm.toggleSavedStatus(for: data)
            }
        } label: {
            Image(vm.savedList.contains(where: { fav in
                fav.buildingId == data.buildingId
            }) ? "favoriteGreyFilledIcon" : "favouriteOutlineGray")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height:20)
            
        }
    }
}
