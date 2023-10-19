//
//  Mapper.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation

final class Mapper {
    
    static func mapGenreResponseToDomain(input response: [Genre]) -> [GenreModel] {
        return response.map {result in
            return GenreModel(
                id: result.id,
                name: result.name
            )
        }
    }
    
    static func mapMovieResponseToDomain(input response: [Movie]) -> [MovieModel] {
        return response.map {result in
            return MovieModel(
                id: result.id ?? 0,
                title: result.title ?? "",
                overview: result.overview ?? "",
                voteAverage: result.voteAverage ?? 0,
                posterPath: result.posterPath ?? "",
                backdropPath: result.backdropPath ?? "",
                releaseDate: result.releaseDate ?? ""
            )
        }
    }
    
    static func mapFavoriteEntityToDomains(input list: [MovieEntity]) -> [MovieModel] {
        return list.map { origin in
            return MovieModel(
                id: origin.id,
                title: origin.title,
                overview: origin.overview,
                voteAverage: origin.voteAverage,
                posterPath: origin.posterPath,
                backdropPath: origin.backdropPath,
                releaseDate: origin.releaseDate
            )
        }
    }
    
    static func mapMovieDomainToEntity(input origin: MovieModel) -> MovieEntity {
        let result = MovieEntity()
        result.id = origin.id
        result.title = origin.title
        result.overview = origin.overview
        result.voteAverage = origin.voteAverage
        result.posterPath = origin.posterPath
        result.backdropPath = origin.backdropPath
        result.releaseDate = origin.releaseDate
        return result
    }
    
    static func mapDetailMovieResponseToDomains(movieResponse: DetailMovieResponse) -> DetailMovieModel {
        let genres = mapGenreResponseToDomains(input: movieResponse)
        let productionCompanies = mapCompaniesResponseToDomains(input: movieResponse)
        
        return DetailMovieModel(
            id: movieResponse.id ?? 0,
            genres: genres,
            homepage: movieResponse.homepage ?? "",
            imdbID: movieResponse.imdbId ?? "",
            originalTitle: movieResponse.originalTitle ?? "",
            overview: movieResponse.overview ?? "",
            popularity: movieResponse.popularity ?? 0,
            posterPath: movieResponse.posterPath ?? "",
            backdropPath: movieResponse.backdropPath ?? "",
            releaseDate: movieResponse.releaseDate ?? "",
            runtime: movieResponse.runtime ?? 0,
            status: movieResponse.status ?? "",
            tagline: movieResponse.tagline ?? "",
            title: movieResponse.title ?? "",
            video: movieResponse.video ?? false,
            voteAverage: movieResponse.voteAverage ?? 0,
            voteCount: movieResponse.voteCount ?? 0,
            productionCompanies: productionCompanies
        )
    }
    
    static func mapGenreResponseToDomains(input response: DetailMovieResponse) -> [GenreModel] {
        return response.genres!.map { GenreModel(id: $0.id, name: $0.name) }
    }
    
    static func mapCompaniesResponseToDomains(input response: DetailMovieResponse) -> [ProductionCompaniesModel] {
        return response.productionCompanies!.map { ProductionCompaniesModel(id: $0.id ?? 0, logoPath: $0.logoPath ?? "", name: $0.name ?? "", originalCountry: $0.originalCountry ?? "")}
    }
    
    static func mapVideoResponseToDomain(input response: Video) -> VideoModel {
        let result = VideoModel(
            name: response.name,
            key: response.key,
            site: response.site,
            size: response.size,
            type: response.type,
            official: response.official,
            publishedAt: response.publishedAt,
            id: response.id
        )
        return result
    }
    
}
