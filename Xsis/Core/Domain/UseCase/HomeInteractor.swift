//
//  HomeInteractor.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation
import Combine

protocol HomeUseCase {
    func fetchGenres() -> AnyPublisher<[GenreModel], Error>
    func fetchMovieByGenre(idGenre: Int, page: Int) -> AnyPublisher<[MovieModel], Error>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchGenres() -> AnyPublisher<[GenreModel], Error> {
        return repository.getGenresMovie()
    }
    
    func fetchMovieByGenre(idGenre: Int, page: Int) -> AnyPublisher<[MovieModel], Error> {
        return repository.getListMoviesByGenre(id: idGenre, page: page)
    }
}
