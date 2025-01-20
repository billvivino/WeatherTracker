//
//  CityCardRow.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//
import SwiftUI

struct CityCardRow: View {
    let city: CitySearchResult
    let onSelectCity: (CitySearchResult) -> Void
    
    @ObservedObject var viewModel: SearchViewModel
    
    // Local state to store loaded data (e.g., icon URL, temp)
    @State private var cityData: CityData?
    
    var body: some View {
        Button {
            onSelectCity(city)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(city.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    // Show loaded data if available
                    if let data = cityData {
                        Text("\(Int(data.temperature))°")
                            .font(.largeTitle)
                            .bold()
                    } else {
                        Spacer()
                    }
                }
                Spacer()
                if let data = cityData,
                    let url = URL(string: data.iconURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 83, height: 67)
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .frame(width: 83, height: 67)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, idealHeight: 117)
        }
        .buttonStyle(BorderedProminentButtonStyle())
        .foregroundStyle(.black)
        .tint(Color(hex: "F2F2F2") ?? .gray)
        .onAppear {
            loadCityData()
        }
    }
    
    private func loadCityData() {
        guard cityData == nil else { return }  // Already loaded
        
        Task {
            let data = await viewModel.fetchCityDataIfNeeded(for: city)
            self.cityData = data
        }
    }
}
