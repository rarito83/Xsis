//
//  DetailMovieModel.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation

struct DetailMovieModel: Identifiable {
    let id: Int
    let genres: [GenreModel]
    let homepage: String
    let imdbID: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    var posterPath: String
    let backdropPath: String
    let releaseDate: String
    let runtime: Int
    var status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    var productionCompanies: [ProductionCompaniesModel]
    var poster: String { IMAGE.imageUrl + posterPath }
    var backdrop: String { IMAGE.imageUrl + backdropPath }
    
    var genre: String {
        return genres.map { $0.name }.joined(separator: ", ")
    }
    
    var prodCompany: String {
        return productionCompanies.map { $0.name }.joined(separator: ", ")
    }
    
    var releaseDateFormatted: String {
        let date = releaseDate.toDate()
        return date.toString(format: "MMM dd, yyyy")
    }
    
    public static var `default`: DetailMovieModel { DetailMovieModel(
        id: 531219, genres: [GenreModel(id: 11, name: ""),
                             GenreModel(id: 12, name: "")],
        homepage: "",
        imdbID: "",
        originalTitle: "",
        overview: "",
        popularity: 1768.318,
        posterPath: "",
        backdropPath: "",
        releaseDate: "",
        runtime: 106,
        status: "",
        tagline: "",
        title: "",
        video: false,
        voteAverage: 7.1,
        voteCount: 492,
        productionCompanies: [ProductionCompaniesModel(id: 1, logoPath: "", name: "", originalCountry: "")]
    )}
}
