//
//  RootTabView.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/30/25.
//


import SwiftUI
import SwiftData

struct RootTabView: View {
    // Pass in any dependencies you need for ContentView and FavoritesView
    @StateObject private var weatherViewModel: WeatherViewModel
    @StateObject private var searchViewModel: SearchViewModel
    
    init(
        weatherViewModel: WeatherViewModel,
        searchViewModel: SearchViewModel
    ) {
        _weatherViewModel = StateObject(wrappedValue: weatherViewModel)
        _searchViewModel = StateObject(wrappedValue: searchViewModel)
    }
    
    var body: some View {
        TabView {
            // 1) Main Weather View
            ContentView(
                weatherViewModel: weatherViewModel,
                searchViewModel: searchViewModel
            )
            .tabItem {
                Label("Weather", systemImage: "cloud.sun")
            }

            // 2) Favorites List
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    RootTabView(
        weatherViewModel: WeatherViewModel(weatherService: MockWeatherService()),
        searchViewModel: SearchViewModel(weatherService: MockWeatherService())
    )
    .modelContainer(for: [FavoriteCity.self]) // Provide SwiftData container for previews
    .environmentObject(NetworkMonitor())
}