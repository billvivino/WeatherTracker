struct MockWeatherService: WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherData {
        // Return mock data
        return WeatherData(temperature: 65.0, description: "Cloudy")
    }
}

// Unit test
func testWeatherViewModel() async throws {
    let mockService = MockWeatherService()
    let viewModel = WeatherViewModel(weatherService: mockService)

    await viewModel.updateWeather(for: "TestCity")
    // Verify the published weather description is set to mock data
    XCTAssertEqual(viewModel.weatherDescription, "Cloudy and 65.0°")
}