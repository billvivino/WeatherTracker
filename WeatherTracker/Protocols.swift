//
//  Protocols.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//

import Foundation

protocol WeatherServiceProtocol: Sendable {
    func fetchWeather(for id: Int) async throws -> WeatherData
    
    // New: search for matching cities
    func searchCities(matching query: String) async throws -> [CitySearchResult]
}


