//
//  GhibiliMovieAppApp.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import SwiftUI
import SwiftData
@main
struct GhibiliMovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Favourite.self)
        }
    }
}
