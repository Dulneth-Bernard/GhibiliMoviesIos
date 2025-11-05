//
//  FilmScreen.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import SwiftUI

//view builder

//
//  FilmScreen.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import SwiftUI

struct FilmScreen: View {
    // 1. This is the REAL FilmScreen.
    // It accepts the VIEW MODELS from ContentView.
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                // 2. It SWITCHES on the loading state
                switch filmsViewModel.state {
                case .idle:
                    Text("No Films yet")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                // 3. When loaded, it will call "FilmListView"
                // (which we will create in the next step)
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.pink)
                }
            }
        }
    }
}

    // --- MAKE SURE YOU HAVE THIS PRIVATE STRUCT TOO ---
    // It can go in the same file, right below FilmListView
//
//    private struct FilmRow: View {
//        let film: Film
//        let favoritesViewModel: FavoritesViewModel
//        
//        var body: some View {
//            HStack(alignment: .top) {
//                // Assumes you created FilmImageView.swift
//                FilmImageView(urlPath: film.image)
//                    .frame(width: 100, height: 150)
//                
//                VStack(alignment: .leading, spacing: 10) {
//                    Text(film.title)
//                        .bold()
//                    
//                    Text("Directed by \(film.director)")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                    
//                    Text("Released: \(film.releaseYear)")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                    
//                    // Assumes you created FavoriteButton.swift
//                    FavoriteButton(filmID: film.id,
//                                   favoritesViewModel: favoritesViewModel)
//                    .buttonStyle(.plain)
//                    .controlSize(.large)
//                }
//                .padding(.top)
//            }
//        }
//    }


    
    struct FilmImageView: View {
        
        let url: URL?
        
        // You can initialize it with just a string...
        init(urlPath: String) {
            self.url = URL(string: urlPath)
        }
        
        // ...or with a URL object
        init(url: URL?) {
            self.url = url
        }
        
        var body: some View {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    // Show a gray box with a spinner
                    Color(white: 0.8)
                        .overlay {
                            ProgressView()
                                .controlSize(.large)
                        }
                case .success(let image):
                    // Show the image
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                case .failure(_):
                    // Show an error message
                    Text("Could not get image")
                @unknown default:
                    fatalError()
                }
            }
        }
    }

    struct FilmDetailScreen: View {
        let film: Film
        let favoritesViewModel: FavoritesViewModel
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // 1. Use your FilmImageView for the banner
                    FilmImageView(urlPath: film.bannerImage)
                        .frame(height: 250)
                        .clipped()
                    
                    // 2. Add a section for Title and Favoriting
                    HStack(alignment: .top) {
                        Text(film.title)
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                        
                        // 3. Reuse your FavoriteButton!
                        FavoriteButton(filmID: film.id,
                                       favoritesViewModel: favoritesViewModel)
                        .controlSize(.large)
                    }
                    .padding()
                    
                    // 4. Add the film's description
                    Text(film.description)
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    // 5. Add a divider for style
                    Divider()
                        .padding(.horizontal)
                    
                    // 6. Add all the other details
                    VStack(alignment: .leading, spacing: 10) {
                        InfoRow(label: "Directed by", value: film.director)
                        InfoRow(label: "Produced by", value: film.producer)
                        InfoRow(label: "Release Year", value: film.releaseYear)
                        InfoRow(label: "Running Time", value: "\(film.duration) mins")
                        InfoRow(label: "Rotten Tomatoes", value: "\(film.score) / 100")
                    }
                    .padding()
                }
            }
            .navigationTitle(film.title) // Show title in nav bar when scrolled
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .top) // Let the banner go to the top
        }
    }
    
    private struct InfoRow: View {
        let label: String
        let value: String
        
        var body: some View {
            HStack {
                Text(label)
                    .font(.headline)
                    .frame(width: 140, alignment: .leading)
                Text(value)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    
    struct FavoriteButton: View {
        
        let filmID: String
        let favoritesViewModel: FavoritesViewModel
        
        // A computed property to check if this film is a favorite
        var isFavorite: Bool {
            favoritesViewModel.isFavorite(filmID: filmID)
        }
        
        var body: some View {
            Button {
                // When tapped, just tell the view model to toggle
                favoritesViewModel.toggleFavorite(filmID: filmID)
            } label: {
                // The label changes based on the 'isFavorite' property
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(isFavorite ? Color.pink : Color.gray)
            }
        }
    }


//#Preview {
//    // 1. Create a "mock" film
//    let mockFilm = Film(
//        id: "1",
//        title: "My Neighbor Totoro",
//        description: "...",
//        director: "...",
//        producer: "...",
//        releaseYear: "1988",
//        score: "94",
//        duration: "86",
//        image: "",
//        bannerImage: "",
//        people: []
//    )
//    
//    // 2. Pass it to your screen
//    return NavigationStack { // Add NavigationStack so the links work in preview
//        FilmScreen(
//            films: [mockFilm, mockFilm],
//            favoritesViewModel: FavoritesViewModel()
//        )
//    }
//}
