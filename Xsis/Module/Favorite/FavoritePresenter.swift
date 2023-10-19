//
//  FavoritePresenter.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation
import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private var router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var movies: [MovieModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func fetchMovies() {
        loadingState = true
        favoriteUseCase.action()
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
        NavigationLink(destination: router.makeFavoriteView(for: movie)) { content() }
    }
}
