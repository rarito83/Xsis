//
//  MovieResponse.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation

struct MovieResponse: Decodable {
  let movies: [Movie]
  
  internal enum CodingKeys: String, CodingKey {
    case movies = "results"
  }
}

struct Movie: Decodable {
  let id: Int?
  let title, overview, posterPath, backdropPath, releaseDate: String?
  let voteAverage: Double?
  
  internal enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case overview = "overview"
    case voteAverage = "vote_average"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
  }
}
