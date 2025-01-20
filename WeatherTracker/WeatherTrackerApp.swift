//
//  WeatherTrackerApp.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//

import SwiftUI

@main
struct WeatherTrackerApp: App {
    let weatherService: WeatherServiceProtocol = APIWeatherService()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                weatherViewModel: WeatherViewModel(weatherService: weatherService),
                searchViewModel: SearchViewModel(weatherService: weatherService)
            )
        }
    }
}
