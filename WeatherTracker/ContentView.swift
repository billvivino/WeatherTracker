//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherViewModel: WeatherViewModel
    @StateObject private var searchViewModel: SearchViewModel
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    
    @State private var searchText: String = ""
    @AppStorage("cityId") var cityId: Int?
    @FocusState private var isSearchFieldFocused: Bool
    
    // Custom init for dependency injection
    init(weatherViewModel: WeatherViewModel, searchViewModel: SearchViewModel) {
        _weatherViewModel = StateObject(wrappedValue: weatherViewModel)
        _searchViewModel = StateObject(wrappedValue: searchViewModel)
    }
    
    var body: some View {
        VStack {
            // Search Bar in a ZStack
            
            // MARK: - Search Bar
            HStack {
                TextField("Search Location", text: $searchViewModel.searchText)
                    .padding(.leading, 16)
                    .focused($isSearchFieldFocused)
                    .onSubmit {
                        Task {
                            await weatherViewModel.updateWeather(for: searchViewModel.searchText, networkMonitor: self.networkMonitor)
                            searchViewModel.clearSearchResults()
                            searchViewModel.searchText = ""
                        }
                    }
                
                Spacer()
                
                // If there's text, show an X button
                if !searchViewModel.searchText.isEmpty {
                    Button {
                        searchViewModel.searchText = ""
                        searchViewModel.clearSearchResults()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                } else {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                }
            }
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .padding(.horizontal)
            // MARK: - End Search Bar
            
            Spacer()
            
            if !searchViewModel.citySearchResults.isEmpty,
               !searchViewModel.searchText.isEmpty {
                // Make sure the list is below the search field
                SearchResultsView(
                    results: searchViewModel.citySearchResults,
                    onSelectCity: { cityResult in
                        // On select city
                        cityId = cityResult.id
                        isSearchFieldFocused = false
                        Task {
                            await weatherViewModel.updateWeather(for: cityResult.id, networkMonitor: self.networkMonitor)
                            searchViewModel.clearSearchResults()
                            searchViewModel.searchText = ""
                        }
                    },
                    viewModel: searchViewModel
                )
            } else if searchViewModel.citySearchResults.isEmpty,
                      !searchViewModel.searchText.isEmpty {
                EmptyView()
            } else if weatherViewModel.fetchError == nil {
                if cityId != nil {
                    if let weather = weatherViewModel.weatherData {
                        // MARK: - Weather Icon with Overlaid Avatars
                        ZStack(alignment: .topTrailing) {
                            // Main weather graphic (e.g., sun behind clouds)
                            if let iconURL = URL(string: weather.weatherIcon) {
                                AsyncImage(url: iconURL) { phase in
                                    switch phase {
                                    case .empty:
                                        // The image is loading
                                        ProgressView()
                                    case .success(let image):
                                        // The image loaded successfully
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    case .failure(_):
                                        // The image failed to load
                                        Image(systemName: "exclamationmark.triangle")
                                            .resizable()
                                            .scaledToFit()
                                    @unknown default:
                                        // Fallback for any new cases Swift adds in the future
                                        EmptyView()
                                    }
                                }
                                .frame(width: 150, height: 150)
                            }
                        }
                        
                        // MARK: - City Name + Location Arrow
                        HStack(spacing: 6) {
                            Text(weather.name)
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            // A small arrow or location indicator
                            Image(systemName: "paperplane.fill")
                                .font(.title3)
                        }
                        
                        // MARK: - Current Temperature
                        Text("\(Int(weather.temperature))°")
                            .font(.system(size: 64, weight: .bold))
                        
                        // MARK: - Bottom Stats Bar
                        
                        HStack {
                            // 1) Humidity
                            WeatherStatView(
                                title: "Humidity",
                                value: "\(Int(weather.humidity))%"
                            )
                            Spacer()
                            
                            // 2) UV
                            WeatherStatView(
                                title: "UV",
                                value: "\(Int(weather.uvIndex))"
                            )
                            Spacer()
                            
                            // 3) Feels Like
                            WeatherStatView(
                                title: "Feels Like",
                                value: "\(Int(weather.feelsLikeTemperature))°"
                            )
                        }
                        .padding(16)
                        .background(Color(hex: "F2F2F2"))
                        .frame(width: 274, height: 75)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    } else {
                        VStack(spacing: 8) {
                            Text("Weather Data Unavailable")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("Please Try Again Later")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                    Spacer()
                } else {
                    // Centered "No City Selected" & "Please Search For A City"
                    VStack(spacing: 8) {
                        Text("No City Selected")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Please Search For A City")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                
                Spacer()
            } else {
                VStack(spacing: 8) {
                    if let error = weatherViewModel.fetchError,
                       error as! WeatherFetchError == WeatherFetchError.noNetwork {
                        Text("Error Fetching Weather Data")
                            .font(.title)
                            .fontWeight(.bold)
                    } else {
                        Text("Invalid City Name")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    if let error = weatherViewModel.fetchError {
                        Text(error.localizedDescription)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                    }
                }
                
                Spacer()
            }
        }
        .padding()
        .onAppear {
            if let cityId = cityId {
                Task {
                    await weatherViewModel.updateWeather(for: cityId, networkMonitor: self.networkMonitor)
                }
            }
        }
    }
}

#Preview {
    // 1) Some view test cases in UserDefaults
    ContentView(
        weatherViewModel:
            WeatherViewModel(
                weatherService: MockWeatherService()
            ),
        searchViewModel:
            SearchViewModel(
                weatherService: MockWeatherService()
            )
    )
    .environmentObject(NetworkMonitor())
    .onAppear {
        UserDefaults.standard.set(524901, forKey: "cityId")
    }
}
