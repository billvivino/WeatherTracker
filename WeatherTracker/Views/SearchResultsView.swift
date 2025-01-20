//
//  SearchResultsView.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//
import SwiftUI

struct SearchResultsView: View {
    let results: [CitySearchResult]
    
    /// Called when the user taps a city card
    let onSelectCity: (CitySearchResult) -> Void
    @State private var weatherDataArray: [WeatherData] = []
    
    // Local state to store loaded data (e.g., icon URL, temp)
    @State private var cityData: CityData?
    
    /// The ViewModel that holds our cache
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        if viewModel.searchError != nil {
            VStack(spacing: 8) {
                Text("Something went wrong")
                    .font(.title)
                    .fontWeight(.bold)
                
                if let error = viewModel.searchError {
                    Text(error.localizedDescription)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
            }
        } else {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(results) { city in
                        CityCardRow(
                            city: city,
                            onSelectCity: onSelectCity,
                            viewModel: viewModel
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SearchResultsView(
        results: [
            CitySearchResult(
                id: 2796590,
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
        ], onSelectCity: { _ in },
        viewModel: SearchViewModel(
            weatherService: MockWeatherService()
        )
    )
}
