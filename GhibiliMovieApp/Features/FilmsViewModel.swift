//
//  FilmsViewModel.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import Foundation
//ios 17+
import Observation

@Observable
class FilmsViewModel{
    //View modesl keep track of the states
    var state : LoadingState<[Film]> = .idle
    
    private let networkService : NetworkService
    
    init(networkService: NetworkService = DefaultNetworkingService() as! NetworkService) {
        
        self.networkService = networkService
    }
    
    func fetch() async  {
        guard !state.isLoading || state.error != nil else { return }
        
        state = .loading
        
        do {
            let films = try await networkService.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError{
            self.state = .error(error.errorDescription ?? "An unknown error occured")
        } catch {
            self.state = .error("An unknown error occured")
        }
        
    }
    
    
    
}
