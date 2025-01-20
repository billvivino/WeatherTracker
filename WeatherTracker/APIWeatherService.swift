//
//  APIWeatherService.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//

import Foundation


struct APIWeatherService: WeatherServiceProtocol {
    private struct WeatherAPIResponse: Decodable {
        let location: Location
        let current: Current
        
        struct Location: Decodable {
            let name: String
        }
        
        struct Current: Decodable {
            let temp_c: Double
            let condition: Condition
            let humidity: Int
            let uv: Double
            let feelslike_c: Double
            
            struct Condition: Decodable {
                let text: String
                let icon: String
            }
        }
    }
    
    // Safely unwrap the key from Info.plist
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
            fatalError("API Key not found in Info.plist!")
        }
        return key
    }
    
    func fetchWeather(for id: Int) async throws -> WeatherData {
        // 1) Build the request URL with the user’s city input
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=id:\(id)&aqi=no"
        
        // 2) Safely unwrap the URL
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // 3) Fetch data asynchronously
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // 4) Decode JSON into our temporary WeatherAPIResponse struct
        let decoded = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
        
        // If the string starts with "//", add "https:" in front
        let rawIconURL = decoded.current.condition.icon
        let weatherIcon = rawIconURL.hasPrefix("//") ? "https:" + rawIconURL : rawIconURL
        
        // 5) Map the decoded JSON fields to our WeatherData model
        return WeatherData(
            name: decoded.location.name,
            temperature: decoded.current.temp_c,
            weatherCondition: decoded.current.condition.text,
            weatherIcon: weatherIcon,
            humidity: Double(decoded.current.humidity),
            uvIndex: decoded.current.uv,
            feelsLikeTemperature: decoded.current.feelslike_c
        )
    }
    
    // New method to hit /search.json
    func searchCities(matching query: String) async throws -> [CitySearchResult] {
        // WeatherAPI docs: GET /search.json?key=YOUR_KEY&q=QUERY
        let urlString = "https://api.weatherapi.com/v1/search.json?key=\(apiKey)&q=\(query)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode into an array of CitySearchResult
        return try JSONDecoder().decode([CitySearchResult].self, from: data)
    }
}
