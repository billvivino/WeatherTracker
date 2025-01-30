//
//  Models.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//

import Foundation
import SwiftData

@Model
class FavoriteCity {
    // Must be `var` for SwiftData to track changes
    var cityId: Int
    var name: String
    
    init(cityId: Int, name: String) {
        self.cityId = cityId
        self.name = name
    }
}

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

enum WeatherFetchError: LocalizedError {
    case noNetwork
    
    var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "You appear to be offline. Please connect to the internet and try again."
        }
    }
}

enum SearchError: LocalizedError {
    case noNetwork
    
    var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "You appear to be offline. Please connect to the internet and try again."
        }
    }
}
