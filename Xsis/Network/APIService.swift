//
//  APIService.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation

struct APIService {
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let youtubeUrl = "https://www.youtube.com/watch"
    public static var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "MDB_Info", ofType: "plist") else {
                fatalError("Couldn't find file 'MDB_Info.plist'.")
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_Key") as? String else {
                fatalError("Couldn't find key 'API_Key' in 'MDB_Info.plist'.")
            }
            return value
        }
    }
}

struct IMAGE {
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case genre
        case popular
        case search
        case detail
        case video
        
        public var url: String {
            switch self {
            case .genre: return "\(APIService.baseUrl)genre/movie/list"
            case .popular: return "\(APIService.baseUrl)movie/popular"
            case .search: return "\(APIService.baseUrl)search/movie"
            case .detail: return "\(APIService.baseUrl)movie"
            case .video: return "\(APIService.baseUrl)movie"
            }
        }
    }
}

func genreMovie(idGenre: Int) -> String { return "\(idGenre)"}
func detailMovie(idMovie: Int) -> String { return "/\(idMovie)"}
func searchMovie(query: String) -> String { return "/\(query)"}
func movieTrailer(idMovie: Int) -> String { return "/\(idMovie)/videos"}

enum URLError: LocalizedError {
    
    case invalidResponse
    case addressUnreachable(URL)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }
    
}

enum DatabaseError: LocalizedError {
    
    case invalidInstance
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        }
    }
}
