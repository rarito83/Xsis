//
//  DetailPresenter.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var movie: MovieModel
    @Published var detailMovie: DetailMovieModel = DetailMovieModel.default
    @Published var videoMovie: String?
    @Published var video: VideoModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isFavorite: Bool = false
    
    init(
        movie: MovieModel,
        detailUseCase: DetailUseCase,
        favoriteUseCase: FavoriteUseCase
    ) {
        self.movie = movie
        self.detailUseCase = detailUseCase
        self.favoriteUseCase = favoriteUseCase
    }
    
    func fetchDetailMovie() {
        loadingState = true
        detailUseCase.fetchDetailMovie(idMovie: movie.id)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { detailMov in
                self.detailMovie = detailMov
                if (self.detailMovie.id == 0) { self.fetchMovieTrailer(id: self.detailMovie.id) }
            }.store(in: &cancellables)
    }
    
    func fetchMovieTrailer(id: Int) {
        loadingState = true
        print("fetch movie trailer: \(detailMovie.id)")
        detailUseCase.fetchVideo(idMovie: detailMovie.id)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                case .finished:
                    self.loadingState = false
                }
            } receiveValue: { video in
                self.videoMovie = "https://www.youtube.com/watch?v=\(video.key)"
                print("key movie trailer:", self.videoMovie as Any)
            }.store(in: &cancellables)
    }
    
    func checkFavorite() {
        favoriteUseCase.statusFavorite(id: movie.id)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    print("getFavoriteStatus success")
                }
            } receiveValue: { isFavorite in
                self.isFavorite = isFavorite
            }
            .store(in: &cancellables)
    }
    
    func addFavorite() {
        self.isFavorite = true
        favoriteUseCase.actionAdd(movie: movie)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { success in
                print("addFavorite \(success)")
                self.isFavorite = true
            }
            .store(in: &cancellables)
    }
    
    func removeFavorite() {
        favoriteUseCase.actionRemove(id: movie.id)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { success in
                print("removeFavorite \(success)")
                self.isFavorite = false
            }
            .store(in: &cancellables)
    }
}
