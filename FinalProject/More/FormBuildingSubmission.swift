//
//  FormBuildingSubmission.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-14.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


//custom back button since tint doesn't work
//https://stackoverflow.com/questions/56571349/custom-back-button-for-navigationviews-navigation-bar-in-swiftui

struct FormBuildingSubmission: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var vm: BuildingViewModel
    @State var submission: Submission = Submission()
    var categories: [String] {
        return if vm.currentLanguage == "en" { vm.categoriesListEN } else { vm.categoriesListFR }
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some View {
        //CHECK INTERNET CONNECTION
        NavigationStack {
            Form {
                Section {
                    Text("Building name:")
                    TextField("", text: $submission.name)
                        .font(.headline)
                        .frame(minHeight: 30)
                }
                
                Section {
                    Text("Building description:")
                    TextEditor(text: $submission.description)
                        .frame(minHeight: 100)
                }
                
                Section {
                    Picker("Building Category:", selection: $submission.category) {
                        ForEach(categories, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
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
                        Text("Suggestions")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(5)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        vm.submitBuilding(building: submission)
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Submit")
                            .foregroundStyle(.white)
                    })
                    
                }
            }
            .toolbarBackground(Color.customDarkBlue, for: .navigationBar)
            .toolbarBackground(.visible)
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

#Preview {
    ContentView().environmentObject(BuildingViewModel())
}
