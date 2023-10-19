//
//  GenreResponse.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation

struct GenreResponse: Decodable {
  let genres: [Genre]
  
  internal enum CodingKeys: String, CodingKey {
    case genres = "genres"
  }
}

struct Genre: Decodable {
  let id: Int
  let name: String
  
  internal enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
  }
}
