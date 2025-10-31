//
//  NetworkService.swift
//  GhibiliMovieApp
//
//  Created by Dulneth Bernard on 31/10/2025.
//

import Foundation

protocol NetworkService:Sendable{
    func fetchFilms() async throws -> [Film]
    func fetchPerson(url:String) async throws -> Person
}

//API STATES: idle>loading>loaded then sucess / error
