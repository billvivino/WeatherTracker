//
//  FavoritesView.swift
//  WeatherTracker
//
//  Created by Bill Vivino on 1/30/25.
//
import SwiftUI
import SwiftData

struct FavoritesView: View {
    // SwiftData automatically fetches all FavoriteCity objects sorted by name
    @Query(sort: \FavoriteCity.name) var favoriteCities: [FavoriteCity]
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        EmptyView()
        List {
            ForEach(favoriteCities) { city in
                let idString = String(city.cityId)
                Text("\(city.name) (ID: \(idString))")
                    .swipeActions {
                        Button("Delete") {
//                            self.removeFavorite(at: <#T##IndexSet#>)
                        }
                    }
            }
            .onDelete(perform: removeFavorite)
        }
        .navigationTitle("Favorites")
    }
    
    private func removeFavorite(at offsets: IndexSet) {
        offsets.map { favoriteCities[$0] }
               .forEach { context.delete($0) }
        // SwiftData auto-saves changes at times, but you can also call:
        // try? context.save()
    }
}
