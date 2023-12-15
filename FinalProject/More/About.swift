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
            Image("selfie_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .border(Color.black, width: 4)
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Teagan Clayton")
                    .fontWeight(.bold)
                
                Text("Junior Developer")
                    .padding(.bottom)
                
                Divider()
            }
            .font(.title3)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "envelope")
                    Text("clay0063@algonquinlive.com")
                }
                HStack {
                    Image(systemName: "ellipsis.curlybraces")
                    NavigationLink("Github", destination: SafariViewWrap(url: fixURL("http://github.com/clay0063")!)).ignoresSafeArea()
                    Spacer()
                }
                .padding(.top, 5)
            }
            .padding(.vertical)
            Divider()
        }
        .padding()
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
