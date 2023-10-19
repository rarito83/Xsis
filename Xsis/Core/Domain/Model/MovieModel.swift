//
//  MovieModel.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation

struct MovieModel: Equatable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    var rating: Float { Float(voteAverage * 10) }
    let posterPath: String
    var poster: String { IMAGE.imageUrl + posterPath }
    let backdropPath: String
    var backdrop: String { IMAGE.imageUrl + backdropPath }
    let releaseDate: String
    
    var releaseDateFormatted: String {
        let date = releaseDate.toDate()
        return date.toString(format: "MMM dd,yyyy")
    }
}
