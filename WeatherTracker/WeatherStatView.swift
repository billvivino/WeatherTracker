/// A simple vertical stack for any weather stat (Humidity, UV, etc.).
struct WeatherStatView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

// MARK: - Preview

#Preview {
    WeatherDetailView(
        weather: WeatherData(
            city: "Hyderabad",
            temperature: 31,
            humidity: 20,
            uv: 4,
            feelsLike: 38,
            conditionText: "Partly Cloudy"
        )
    )
}