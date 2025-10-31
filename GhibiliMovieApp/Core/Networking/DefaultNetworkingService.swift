//
//  DefaultGhibilService.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import Foundation

struct DefaultNetworkingService {
    func fetch<T: Decodable>(urlString: String, type: T.Type) async throws -> T {
        //errors arent going to be handledw within fetch function but happens on usage
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
           return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
