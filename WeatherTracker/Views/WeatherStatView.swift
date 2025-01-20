//
//  WeatherStatView.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//
import SwiftUI

/// A simple vertical stack for any weather stat (Humidity, UV, etc.).
struct WeatherStatView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.body)
                .foregroundStyle(.tertiary)
            Text(value)
                .font(.body)
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    WeatherStatView(title: "UV", value: "4")
}


