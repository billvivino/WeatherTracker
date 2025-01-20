//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//
import SwiftUI
import Combine

@MainActor
final class WeatherViewModel: ObservableObject, Sendable {
    private let weatherService: WeatherServiceProtocol
    @Published var weatherData: WeatherData?
    @Published var isLoading: Bool = false
    @Published var fetchError: Error?


    // Constructor (initializer) injection
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func updateWeather(for id: Int) async {
        isLoading = true
        fetchError = nil

        do {
            let data = try await weatherService.fetchWeather(for: id)
            self.weatherData = data
        } catch {
            self.fetchError = error
            self.weatherData = nil
        }
        
        isLoading = false
    }
}
