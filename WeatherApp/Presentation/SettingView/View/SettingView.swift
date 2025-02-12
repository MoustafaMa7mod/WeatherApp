//
//  SettingView.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import SwiftUI

struct SettingView: View {

    @StateObject var viewModel: SettingViewModel

    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Toggle(isOn: $viewModel.isCelsius) {
                        Text("Use Celsius")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.darkAppBlue)
                    }
                    .tint(Color.darkAppBlue)
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                
                Spacer()
                
                Text(viewModel.versionTitle)
                    .font(.footnote)
                    .foregroundColor(Color.darkAppBlue)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(12)
            .background(Color.appBlue)
            .navigationTitle("Setting")
        }
    }
}
