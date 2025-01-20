import Foundation

final class CityPersistenceManager {
    private let selectedCityKey = "SelectedCity"
    
    static let shared = CityPersistenceManager()
    
    private init() {}
    
    /// Saves the selected city to UserDefaults
    func saveSelectedCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: selectedCityKey)
    }
    
    /// Retrieves the selected city from UserDefaults
    func getSelectedCity() -> String? {
        return UserDefaults.standard.string(forKey: selectedCityKey)
    }
}