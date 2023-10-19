//
//  RemoteDataSource.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {
    func getGenres() -> AnyPublisher<[Genre], Error>
    func getListMoviesByGenre(id: Int, page: Int) -> AnyPublisher<[Movie], Error>
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieResponse, Error>
    func getVideoMovie(idMovie: Int) -> AnyPublisher<Video, Error>
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getGenres() -> AnyPublisher<[Genre], Error> {
        return Future<[Genre], Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Gets.genre.url) {
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: APIService.apiKey)
                ]
                
                if let url = URL(string: "\(urlComponent)") {
                    print("URL Genre: \(urlComponent)")
                    AF.request(url)
                        .validate()
                        .responseDecodable(of: GenreResponse.self) { response in
                            switch response.result {
                            case .success(let value):
                                completion(.success(value.genres))
                            case .failure:
                                completion(.failure(URLError.invalidResponse))
                            }
                        }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getListMoviesByGenre(id: Int, page: Int) -> AnyPublisher<[Movie], Error> {
        return Future<[Movie], Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Gets.popular.url) {
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: APIService.apiKey),
                    URLQueryItem(name: "with_genres", value: String(id)),
                    URLQueryItem(name: "page", value: String(page))
                ]
                
                if let url = URL(string: "\(urlComponent)") {
                    print("URL Movies: \(urlComponent)")
                    AF.request(url)
                        .validate()
                        .responseDecodable(of: MovieResponse.self) { response in
                            switch response.result {
                            case .success(let value):
                                completion(.success(value.movies))
                            case .failure:
                                completion(.failure(URLError.invalidResponse))
                            }
                        }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieResponse, Error> {
        let params: Parameters = [
            "api_key": APIService.apiKey
        ]
        
        return Future <DetailMovieResponse, Error> { completion in
            if let requestURL = URL(string: Endpoints.Gets.detail.url+detailMovie(idMovie: idMovie)) {
                AF.request(requestURL, method: .get, parameters: params)
                    .validate()
                    .responseDecodable(of: DetailMovieResponse.self) {response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(
                                .failure(URLError.invalidResponse)
                            )
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func searchMovieByTitle(query: String) -> AnyPublisher<[Movie], Error> {
        return Future<[Movie], Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Gets.search.url) {
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: APIService.apiKey),
                    URLQueryItem(name: "query", value: query)
                ]
                
                if let url = URL(string: "\(urlComponent)") {
                    print("URL Search Movies: \(urlComponent)")
                    AF.request(url)
                        .validate()
                        .responseDecodable(of: MovieResponse.self) { response in
                            switch response.result {
                            case .success(let value):
                                completion(.success(value.movies))
                            case .failure:
                                completion(.failure(URLError.invalidResponse))
                            }
                        }
                }
            }
        }.eraseToAnyPublisher()
//        let params: Parameters = [
//            "api_key": APIService.apiKey
//        ]
//
//        return Future<[Movie], Error> { completion in
//            if let urlComponent = URLComponents(string: Endpoints.Gets.search.url+searchMovie(query: query)) {
//                if let url = URL(string: "\(urlComponent)") {
//                    print("URL Search Movies: \(urlComponent)")
//                    AF.request(url, method: .get, parameters: params)
//                        .validate()
//                        .responseDecodable(of: MovieResponse.self) { response in
//                            switch response.result {
//                            case .success(let value):
//                                completion(.success(value.movies))
//                            case .failure:
//                                completion(.failure(URLError.invalidResponse))
//                            }
//                        }
//                }
//            }
//        }.eraseToAnyPublisher()
    }
    
    func getVideoMovie(idMovie: Int) -> AnyPublisher<Video, Error> {
        let params: Parameters = [
            "api_key": APIService.apiKey
        ]
        
        return Future<Video, Error> { completion in
            if let urlComponent = URLComponents(string: Endpoints.Gets.video.url+movieTrailer(idMovie: idMovie)) {
                if let url = URL(string: "\(urlComponent)") {
                    print("URL Video: \(urlComponent)")
                    AF.request(url, method: .get, parameters: params)
                        .validate()
                        .responseDecodable(of: VideoResponse.self) { response in
                            switch response.result {
                            case .success(let value):
                                if (value.results.first?.key == "") { return } else {
                                    completion(.success(value.results.first!))
                                }
                            case .failure:
                                completion(.failure(URLError.invalidResponse))
                            }
                        }
                }
            }
        }.eraseToAnyPublisher()
    }
}
