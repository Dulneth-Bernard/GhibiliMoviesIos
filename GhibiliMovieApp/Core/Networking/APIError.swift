//
//  APIError.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//


//Assoicated Vlaues with Enums(Decoding)
// inheriting Api error and giving descriptive erros for relavanrt cases

//defibe custom errors we give LocalisedError
//associated error

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "The URL is invalid"
            case .invalidResponse:
                return "Invalid response from server"
            case .decoding(let error):
                return "Failed to decode response: \(error.localizedDescription)"
            case .networkError(let error):
               return "Network error: \(error.localizedDescription)"
        }
    }
}
