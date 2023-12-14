//
//  MoreView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Language")
                //If French, change the content of the app to the french, the data of the french is provided in the json file
                //Will have to fix category sorting for French
                NavigationLink(destination: FormBuildingSubmission(), label: {
                    Text("Recommend a Building")
                })
                //Name of the building, Category, Description
                Text("About portfolio")
                //Image of yourself & Email
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(alignment: .center) {
                        Image("ic_logo_new")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                        Text("More")
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
