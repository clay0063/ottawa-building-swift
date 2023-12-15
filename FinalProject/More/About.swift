//
//  About.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-15.
//

import SwiftUI
import SafariServices

struct About: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var vm: BuildingViewModel
    
    
    var body: some View {
        NavigationStack {
            Image(systemName: "person")
            VStack {
                Text("Teagan Clayton")
                Text("Junior Developer")
            }
            VStack {
                Text("clay0063@algonquinlive.com")
            }
            VStack {
                NavigationLink("Visit Website", destination: SafariViewWrap(url: fixURL("http://github.com/clay0063")!)).ignoresSafeArea()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Back")
                        .foregroundStyle(.white)
                })
                
            }
            ToolbarItem(placement: .principal) {
                Text("About")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(5)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.customDarkBlue, for: .navigationBar)
        .toolbarBackground(.visible)
        .navigationBarBackButtonHidden(true)
    }
    
    
}

#Preview {
    ContentView().environmentObject(BuildingViewModel())
}
