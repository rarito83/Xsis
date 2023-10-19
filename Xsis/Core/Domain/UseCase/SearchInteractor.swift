//
//  SearchInteractor.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation
import Combine

protocol SearchUseCase {
    func actionSearch(query: String) -> AnyPublisher<[MovieModel], Error>
}

class SearchInteractor: SearchUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func actionSearch(query: String) -> AnyPublisher<[MovieModel], Error> {
        return repository.searchingMovie(query: query)
    }
}
