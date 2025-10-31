//
//  LoadingState.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import Foundation


//Case Loaded or Case() loaded(Person) we can make it generic using loaded T

enum LoadingState<T:Equatable>: Equatable{
    case idle
    case loading
    case loaded(T)
    case error(String)
    
    var isLoading: Bool{
        if case .loading = self {
            return true
        }
        return false
    }
    
    var data: T? {
        if case .loaded(let value) = self {
            return value
        }
        return nil
    }
    var error: String? {
        //one line function
        if case .error(let message) = self {return message}
        return nil
        
    }
}
