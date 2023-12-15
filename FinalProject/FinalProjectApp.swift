//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-11-24.
//

import SwiftUI
import Firebase

@main
struct FinalProjectApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(BuildingViewModel())
        }
    }
}
