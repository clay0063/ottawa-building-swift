//
//  MoreView.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-27.
//

import SwiftUI

struct MoreView: View {
    @EnvironmentObject var vm: BuildingViewModel
    @Environment(\.dismiss) var dismissMe
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Button(action: {
                        vm.toggleLanguage()
                    }, label: {
                        if vm.currentLanguage == "en"
                        {
                            Text("Changer la langue au français")
                        } else {
                            Text("Change language to English")
                        }
                    })
                    .padding(.vertical)
                    
                    NavigationLink(destination: FormBuildingSubmission(), label: {
                        Text("Recommend a Building")
                    })
                    .padding(.vertical)
                    
                    Text("About portfolio")
                    .padding(.vertical)
                    
                }
                
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
    ContentView().environmentObject(BuildingViewModel())
}
