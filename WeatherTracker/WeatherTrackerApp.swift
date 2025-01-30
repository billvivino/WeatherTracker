//
//  WeatherTrackerApp.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//

import SwiftUI
import SwiftData

@main
struct WeatherTrackerApp: App {
    let weatherService: WeatherServiceProtocol = APIWeatherService()
    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            RootTabView(
                weatherViewModel: WeatherViewModel(weatherService: weatherService),
                searchViewModel: SearchViewModel(weatherService: weatherService)
            )
            .environmentObject(networkMonitor)
            // Provide a SwiftData container for your models
            .modelContainer(for: [FavoriteCity.self])
        }
    }
}
