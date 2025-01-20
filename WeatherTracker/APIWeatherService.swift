struct APIWeatherService: WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherData {
        // Actual network call to retrieve weather data
        // ...
        return WeatherData(temperature: 72.0, description: "Sunny")
    }
}