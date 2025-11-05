//
//  ContentView.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // 1. Get the SwiftData context
    // (This requires GhibiliMovieAppApp.swift to have .modelContainer())
    @Environment(\.modelContext) private var modelContext

    // 2. Create and own the ViewModels here.
    // They will be created ONCE and shared with the tabs.
    @State var filmsViewModel = FilmsViewModel()
    @State private var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        // 3. Set up the TabView that holds your screens
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                // Pass the ViewModels into your FilmScreen
                FilmScreen(filmsViewModel: filmsViewModel,
                           favoritesViewModel: favoritesViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                // Pass the *same* ViewModels into your FavouritesScreen
                FavouritesScreen(filmsViewModel: filmsViewModel,
                                 favoritesViewModel: favoritesViewModel)
            }
        }
        .task {
            // 4. When the app loads, configure the view modelsÅ
            favoritesViewModel.configure(modelContext: modelContext)
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
        // Add the model container for the preview to work
        .modelContainer(for: Favourite.self, inMemory: true)
}
