//
//  SavedView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct SavedView: View {
    var dataList: [Building]
    @Binding var savedList: [Building]
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack{
                    if savedList.isEmpty {
                        SavedIsEmptyView()
                    } else {
                        SavedListView(dataList: dataList, savedList: $savedList)
                    }
                    
                }
                .padding(.horizontal)
                .navigationTitle("Saved Buildings")
            }
            
        }
    }
}

#Preview {
    ContentView()
}

struct SavedIsEmptyView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Your saved list is empty!")
                .font(.title)
                .fontWeight(.bold)
            Text("Add some countries to your favorites to see them here.")
                .multilineTextAlignment(.center)
        }
    }
}

struct SavedListView: View {
    var dataList: [Building]
    @Binding var savedList: [Building]
    @State var popUpMenu = false
    
    var body: some View {
        ScrollView {
            ForEach(savedList, id: \.id) { building in
                NavigationLink(
                    destination: BuildingDetailView(data: building, savedList: $savedList, dataList: dataList)
                ) {
                    BuildingCards(data: building)
                }
                
//                .contextMenu {
//                    //context menu allows you to create additional buttons when long pressed
//                    Button(role: .destructive) {
//                        if let index = favorites.firstIndex(where: { $0.id == info.id }) {
//                            favorites.remove(at: index)
//                        }
//                    } label: {
//                        Label("Remove from Favorites", systemImage: "trash")
//                    }
//                }
                
                .onTapGesture {
                    popUpMenu.toggle()
                }
                .padding(.bottom, 20.0)
            }
            
        }
    }
}
