//
//  FavouriteStorage.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import Foundation


import Foundation

protocol FavouriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
