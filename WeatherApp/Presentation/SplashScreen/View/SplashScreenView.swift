//
//  SplashScreenView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import SwiftUI

struct SplashScreenView: View {
    
    var body: some View {
        
        ZStack {
            Color
            .appBlue
            .edgesIgnoringSafeArea(.all)
            
            Image("splashScreen")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)            
        }
    }
}
