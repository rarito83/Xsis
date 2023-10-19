//
//  DetailInteractor.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation
import Combine

protocol DetailUseCase {
    func fetchDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error>
    func fetchVideo(idMovie: Int) -> AnyPublisher<VideoModel, Error>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchDetailMovie(idMovie: Int) -> AnyPublisher<DetailMovieModel, Error> {
        return repository.getDetailMovie(idMovie: idMovie)
    }
    
    func fetchVideo(idMovie: Int) -> AnyPublisher<VideoModel, Error> {
        return repository.getVideo(id: idMovie)
    }
}
