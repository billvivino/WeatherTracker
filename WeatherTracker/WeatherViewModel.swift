class WeatherViewModel: ObservableObject {
    @Published var weatherDescription: String = ""
    private let weatherService: WeatherServiceProtocol

    // Constructor (initializer) injection
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func updateWeather(for city: String) async {
        do {
            let data = try await weatherService.fetchWeather(for: city)
            DispatchQueue.main.async {
                self.weatherDescription = "\(data.description) and \(data.temperature)°"
            }
        } catch {
            // Handle error
        }
    }
}