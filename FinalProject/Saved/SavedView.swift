//
//  SavedView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject var vm: BuildingViewModel
    var lm: LocationManager
    
    var body: some View {
        NavigationStack {
            VStack{
                if vm.savedList.isEmpty {
                    SavedIsEmptyView()
                } else {
                    SavedListView(lm: lm)
                        
                }
                
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(alignment: .center) {
                        Image("ic_logo_new")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                        Text("Saved List")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.leading, 5)
                    }
                    
                }
            }
            .toolbarBackground(Color.customDarkBlue, for: .navigationBar)
            .toolbarBackground(.visible)
        }
        
        
    }
}

#Preview {
    ContentView()
}

struct SavedIsEmptyView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Your saved list is empty.")
                .font(.title)
                .fontWeight(.bold)
            Text("Press \(Image(systemName: "heart")) to add buildings to this list!")
                .multilineTextAlignment(.center)
        }
    }
}

struct SavedListView: View {
    @EnvironmentObject var vm: BuildingViewModel
    var lm: LocationManager
    @State private var searchName = ""
    
    var body: some View {
        ScrollView {
            ForEach(vm.savedList.filter {
                searchName.isEmpty || $0.name.lowercased().contains(searchName.lowercased())
            }, id: \.id) { building in
                NavigationLink(
                    destination: BuildingDetailView(data: building)
                ) {
                    BuildingCards(data: building, lm: lm)
                }
                .padding(.bottom, 20.0)
            }
            
        }.searchable(text: $searchName, prompt: "Search...")
    }
}
