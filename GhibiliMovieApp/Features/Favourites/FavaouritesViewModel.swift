//
//  FavaouritesViewModel.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import Foundation

//configure is gong to save boiler plate code
//refactro for perfermonce
//fatal error we forcefully crash appp

import Foundation
import Observation
import SwiftData

@Observable
class FavoritesViewModel {
    private(set) var favoriteIDs: Set<String> = []
    private var service: FavouriteStorage?
    
    init(service: FavouriteStorage? = nil) {
        self.service = service
    }
    
    func configure(modelContext: ModelContext) {
        guard service == nil else { return }
        service = DefaultFavouriteStorage(modelContext: modelContext)
        load()
    }
    
    func load() {
        guard let service = service else {
            favoriteIDs = []
            return
        }
        favoriteIDs = service.load()
    }
    
    private func save() {
        service?.save(favoriteIDs: favoriteIDs)
    }
    
    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }
        
        save()
    }
    
    
    func isFavorite(filmID: String) -> Bool {
        favoriteIDs.contains(filmID)
    }
}
