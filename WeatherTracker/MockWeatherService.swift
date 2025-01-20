//
//  MockWeatherService.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//


struct MockWeatherService: WeatherServiceProtocol {
    func fetchWeather(for id: Int) async throws -> WeatherData {
        // Return mock data
        return WeatherData(
            name: "New York",
            temperature: 75.0,
            weatherCondition: "Sunny",
            weatherIcon: "https://cdn.weatherapi.com/weather/64x64/day/116.png",
            humidity: 10.0,
            uvIndex: 3,
            feelsLikeTemperature: 72.0
        )
    }
    
    func fetchWeather(for cityString: String) async throws -> WeatherData {
        // Return mock data
        return WeatherData(
            name: "New York",
            temperature: 75.0,
            weatherCondition: "Sunny",
            weatherIcon: "https://cdn.weatherapi.com/weather/64x64/day/116.png",
            humidity: 10.0,
            uvIndex: 3,
            feelsLikeTemperature: 72.0
        )
    }
    
    func searchCities(matching query: String) async throws -> [CitySearchResult] {
        // Return 5 fixed mock search results for any input
        return [
            CitySearchResult(
                id: 1,
                name: "London",
                region: "Greater London",
                country: "United Kingdom",
                lat: 51.52,
                lon: -0.11,
                url: "london-city-of-london-greater-london-united-kingdom"
            ),
            CitySearchResult(
                id: 2,
                name: "Los Angeles",
                region: "California",
                country: "United States",
                lat: 34.05,
                lon: -118.24,
                url: "los-angeles-california-united-states-of-america"
            ),
            CitySearchResult(
                id: 3,
                name: "Hyderabad",
                region: "Telangana",
                country: "India",
                lat: 17.38,
                lon: 78.47,
                url: "hyderabad-telangana-india"
            ),
            CitySearchResult(
                id: 4,
                name: "Tokyo",
                region: "Tokyo Prefecture",
                country: "Japan",
                lat: 35.68,
                lon: 139.69,
                url: "tokyo-tokyo-japan"
            ),
            CitySearchResult(
                id: 5,
                name: "Paris",
                region: "Ile-de-France",
                country: "France",
                lat: 48.86,
                lon: 2.35,
                url: "paris-ile-de-france-france"
            )
        ]
    }
}

