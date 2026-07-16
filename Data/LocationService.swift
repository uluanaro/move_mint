//
//  LocationService.swift
//  MoveMint
//
//  Created by uluana_roshina on 15.07.2026.
//
import Foundation
import CoreLocation
import Combine
@MainActor
final class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var route: [CLLocationCoordinate2D] = []
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func startTracking() {
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            route.append(location.coordinate)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            startTracking()
        }
    }
}
