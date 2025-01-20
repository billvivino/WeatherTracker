//
//  SearchViewModel.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//


import SwiftUI
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var cityCache: [Int: CityData] = [:]  // City ID -> Some cached data

    let weatherService: WeatherServiceProtocol
    
    // For searching:
    @Published var searchText: String = ""
    @Published var citySearchResults: [CitySearchResult] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        setupSearchPipeline()
    }
    
    /// Fetch or retrieve from cache
    func fetchCityDataIfNeeded(for city: CitySearchResult) async -> CityData? {
        // 1) Check the cache first
        if let cached = cityCache[city.id] {
            return cached
        }
        // 2) Otherwise, call the API to get data
        do {
            // Example: a method to fetch weather by city ID
            let fetchedData = try await weatherService.fetchWeather(for: city.id)
            
            // Convert or store it in our CityData struct
            let cityData = CityData(
                temperature: fetchedData.temperature,
                iconURL: fetchedData.weatherIcon
            )
            
            // Save in cache
            cityCache[city.id] = cityData
            return cityData
        } catch {
            return nil
        }
    }
    
    private func setupSearchPipeline() {
        // Debounce searchText so we don't spam the API on every keystroke
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                
                Task {
                    // Clear results if query too short
                    guard query.count > 1 else {
                        self.citySearchResults = []
                        return
                    }
                    
                    do {
                        let results = try await self.weatherService.searchCities(matching: query)
                        self.citySearchResults = results
                    } catch {
                        // handle error
                        self.citySearchResults = []
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func clearSearchResults() {
        citySearchResults = []
    }
}

/// Example struct to hold the data we’re caching
struct CityData {
    let temperature: Double
    let iconURL: String
}
