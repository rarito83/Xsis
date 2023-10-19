//
//  SearchPresenter.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation
import SwiftUI
import Combine

final class SearchPresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private var router = SearchRouter()
    private let searchUseCase: SearchUseCase
    
    @Published var movies: [MovieModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
    
    func searchMovie(text: String) {
        loadingState = true
        searchUseCase.actionSearch(query: text)
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
