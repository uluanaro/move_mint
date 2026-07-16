//
//  RouteMapView.swift
//  MoveMint
//
//  Created by uluana_roshina on 15.07.2026.
//
import SwiftUI
import MapKit

struct RouteMapView: View {
    @StateObject var locationService = LocationService()
    
    var body: some View {
        Map {
            UserAnnotation()
            MapPolyline(coordinates: locationService.route)
                .stroke(Color.blue, lineWidth: 5)
        }
        .frame(height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onAppear {
            locationService.requestPermission()
        }
    }
}
