//
//  Favourite.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import Foundation
import SwiftData

@Model
final class Favourite{
    @Attribute(.unique) var filmId: String
    init(filmId: String ){
        self.filmId = filmId
    }
}
