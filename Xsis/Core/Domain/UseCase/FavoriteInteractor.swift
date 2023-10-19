//
//  FavoriteInteractor.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func action() -> AnyPublisher<[MovieModel], Error>
    func statusFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func actionAdd(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func actionRemove(id: Int) -> AnyPublisher<Bool, Error>
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func action() -> AnyPublisher<[MovieModel], Error> {
        return repository.getFavoriteMovies()
    }
    
    func statusFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return repository.isFavorite(id: id)
    }
    
    func actionAdd(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return repository.addFavorite(movie: movie)
    }
    
    func actionRemove(id: Int) -> AnyPublisher<Bool, Error> {
        return repository.removeFavorite(id: id)
    }
}
