//
//  FilmScreen.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import SwiftUI

//view builder

struct FilmScreen: View {
    @State var filmViewModel: FilmsViewModel = FilmsViewModel()
    var body: some View {
        NavigationStack{
            Group{
                switch filmViewModel.state {
                case .idle:
                    Text("No Films yet")
                case .loading:
                    ProgressView{
                        Text("Loading")
                    }
                case .loaded(let films):
                    ForEach(films){ film in
                        Text(film.title)
                    }
                    
                case .error(let string):
                    Text(error).foregroundStyle(.red)
                }
            }.task {
                await filmViewModel.fetch()
            }
        }
    }
}

#Preview {
    FilmScreen()
}
