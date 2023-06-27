//
//  MoviesService.swift
//  MovieDatabaseSwiftUI
//
//  Created by Tiffany Sakaguchi on 6/27/23.
//

import Foundation

class MoviesService {
    let apiKey = "0990e72f40db5cc1a8a0a81c4dede449"
    
    func getMoviesFromAPI() async throws -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)") else {
            return []
        }
        print(url)
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode(MovieResponse.self, from: data)
        
        return decoded.results
    }
}
