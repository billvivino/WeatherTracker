//
//  Extension+Color.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/20/25.
//

import Foundation

import SwiftUI

extension Color {
    /// Initialize a SwiftUI Color from a hex code string.
    /// - Parameter hex: A 6- or 8-digit hex string (with or without `#`).
    ///   For example: `"#FF0000"` or `"FF0000"` for opaque red; `"#80FF0000"` for semi-transparent red.
    init?(hex: String) {
        // Remove possible leading "#"
        var cleanedHex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "# "))
        
        // If only 6 characters, assume full opacity (alpha = FF)
        if cleanedHex.count == 6 {
            cleanedHex = "FF" + cleanedHex
        }
        
        // Now we should have 8 characters (alpha + RGB)
        guard cleanedHex.count == 8 else {
            return nil
        }
        
        // Convert hex string to an integer
        var hexValue: UInt64 = 0
        guard Scanner(string: cleanedHex).scanHexInt64(&hexValue) else {
            return nil
        }
        
        let alpha = Double((hexValue & 0xFF000000) >> 24) / 255.0
        let red   = Double((hexValue & 0x00FF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x0000FF00) >> 8)  / 255.0
        let blue  = Double(hexValue & 0x000000FF) / 255.0
        
        self = Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

// MARK: - Example Usage

/*
 if let magenta = Color(hex: "#FF00FF") {
    // use magenta
 }
 
 // Without "#"
 let semiTransparentRed = Color(hex: "80FF0000") // alpha=0x80, r=0xFF, g=0x00, b=0x00
*/
