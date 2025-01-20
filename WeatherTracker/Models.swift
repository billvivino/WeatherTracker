//
//  Models.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//

import Foundation

struct WeatherData: Sendable {
    let name: String
    let temperature: Double
    let weatherCondition: String
    let weatherIcon: String
    let humidity: Double
    let uvIndex: Double
    let feelsLikeTemperature: Double
}

struct CitySearchResult: Decodable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}
