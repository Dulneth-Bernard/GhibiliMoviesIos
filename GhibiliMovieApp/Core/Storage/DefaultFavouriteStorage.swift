//
//  DefaultFavouriteStorage.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import Foundation
import SwiftData

//if view we can use @Query
///but if viewmODEL WE CANT USE QerybUILDER ISNTEAD WE USE FETCHdESCRIPTOR
///
///TODO: Just pass film ID
//SAVE FUNCTION is overkill, 2 function for favoriting and unfavouriting markAsFav markAsUnfav

struct DefaultFavouriteStorage : FavouriteStorage{
    //PERSISTING DATA
    let modelContext: ModelContext
    
    
    //TODO: Define custom erro adn handle error from laod functionr rather than print
    
    func load() -> Set<String> {
        let descriptor = FetchDescriptor<Favourite>()
        
        do {
            let favorites = try modelContext.fetch(descriptor)
            return Set(favorites.map { $0.filmId })
        } catch {
            print("Failed to load favorites: \(error)")
            return[]
        }
    }
    
    
    // Break it down to 2 funcs
    // markAsFav & markasUnfav
    func save(favoriteIDs: Set<String>) {
        do {
            // Fetch existing favorites
            let descriptor = FetchDescriptor<Favourite>()
            let existing = try modelContext.fetch(descriptor)
            
            // Determine which ones to add/remove
            let existingIDs = Set(existing.map { $0.filmId })
            
            // Remove favorites that no longer exist
            for favorite in existing where !favoriteIDs.contains(favorite.filmId) {
                modelContext.delete(favorite)
            }
            
            // Add new favorites
            let newIDs = favoriteIDs.subtracting(existingIDs)
            for id in newIDs {
                modelContext.insert(Favourite(filmId: id))
            }
            
            try modelContext.save()
        } catch {
            print("Failed to save favorites: \(error)")
        }
    }
}



