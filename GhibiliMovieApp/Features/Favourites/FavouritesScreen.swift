//
//  FavouritesScreen.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import SwiftUI

struct FavouritesScreen: View {
    // 1. It ACCEPTS the ViewModels from ContentView
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    
    // 2. This computes the list of *only* favorite films
    // It reads from both view models!
    var films: [Film] {
        let favorites = favoritesViewModel.favoriteIDs
        switch filmsViewModel.state {
        case .loaded(let films):
            // Filter the full list to only contain favorites
            return films.filter { favorites.contains($0.id) }
        default:
            return [] // If films aren't loaded, return an empty list
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    // 3. A nice empty state if there are no favorites
                    ContentUnavailableView("No Favorites yet", systemImage: "heart")
                } else {
                    // 4. It REUSES the *exact same* FilmListView!
                    // This is the power of the architecture.
                    FilmListView(films: films,
                                 favoritesViewModel: favoritesViewModel)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

//#Preview {
//    FavouritesScreen()
//}
