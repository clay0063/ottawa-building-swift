//
//  LocationManager.swift
//  FinalProject
//
//  Created by Teagan Clayton on 2023-12-11.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager() 

    @Published var userLocation: CLLocation?
    @Published var hasPermission: Bool = false

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location
            hasPermission = true //allows to check when making variables in views
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            hasPermission = status == .authorizedWhenInUse //toggles the status if user approves/rejects location access later
        }
    
    func findDistanceFromUser(userLat: Double, userLong: Double, buildingLat: Double, buildingLong: Double) -> String {
        let userCoord = CLLocation(latitude: userLat, longitude: userLong)
        let buildingCoord = CLLocation(latitude: buildingLat, longitude: buildingLong)
        
        let distanceInMeters = userCoord.distance(from: buildingCoord)
        let distanceInKM = abs(distanceInMeters / 1000)
        
        return String(format:"%.2f", distanceInKM)
    }
}
