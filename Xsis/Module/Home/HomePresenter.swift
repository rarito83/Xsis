//
//  HomePresenter.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation
import SwiftUI
import Combine

final class HomePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private var router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var genreMovies: [GenreModel] = []
    @Published var movies: [MovieModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var idGenre: Int = 28
    @Published var page: Int = 1
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func fetchGenresMovie() {
        print("Fetch Genre")
        loadingState = true
        homeUseCase.fetchGenres()
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { genre in
                self.genreMovies = genre
            }
            .store(in: &cancellables)
    }
    
    func fetchMovies(id: Int, page: Int) {
        print("Fetch Movie")
        loadingState = true
        homeUseCase.fetchMovieByGenre(idGenre: id, page: page)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { movie in
                self.movies = movie
            }
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for movie: MovieModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: movie)) { content() }
    }
}
