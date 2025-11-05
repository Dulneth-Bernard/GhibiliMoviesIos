//
//  FilmListView.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 05/11/2025.
//

import SwiftUI

// This is the struct that shows the list.
// We renamed it from "FilmScreen" to "FilmListView".
struct FilmListView: View {
    var films: [Film]
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                FilmRow(film: film,
                        favoritesViewModel: favoritesViewModel)
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(film: film,
                             favoritesViewModel: favoritesViewModel)
        }
    }
}

// This is the helper struct for the row

private struct FilmRow: View {
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            FilmImageView(urlPath: film.image)
                .frame(width: 100, height: 150)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(film.title)
                    .bold()
                
                Text("Directed by \(film.director)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Released: \(film.releaseYear)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                FavoriteButton(filmID: film.id,
                               favoritesViewModel: favoritesViewModel)
                .buttonStyle(.plain)
                .controlSize(.large)
            }
            .padding(.top)
        }
    }
}
