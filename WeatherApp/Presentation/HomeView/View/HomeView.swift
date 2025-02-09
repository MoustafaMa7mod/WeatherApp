//
//  HomeView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var locationPermission:LocationPermission=LocationPermission()

    init() {
        locationPermission.requestLocationPermission()
    }
    
    var body: some View {
        VStack {
            
            switch locationPermission.authorizationStatus {
                
            case .notDetermined:
                Text("not determied")
            case .restricted:
                Text("restricted")
            case .denied:
                Text("denied")
            case .authorizedAlways:
                VStack {
                    Text(locationPermission.coordinates?.latitude.description ?? "")
                    Text(locationPermission.coordinates?.longitude.description ?? "")
                    
                }
                
            case .authorizedWhenInUse:
                VStack {
                    Text(locationPermission.coordinates?.latitude.description ?? "")
                    Text(locationPermission.coordinates?.longitude.description ?? "")
                }
                
                
            default:
                Text("no")
            }
            
        }
           .buttonStyle(.bordered)
           
       }
}

#Preview {
    HomeView()
}
