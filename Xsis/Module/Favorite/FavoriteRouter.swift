//
//  FavoriteRouter.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI

class FavoriteRouter {
    func makeFavoriteView(for movie: MovieModel) -> some View {
        let detailUseCase = Injection.init().provideDetail()
        let favoriteUseCase = Injection.init().provideFavorites()
        let presenter = DetailPresenter(movie: movie,
                                        detailUseCase: detailUseCase,
                                        favoriteUseCase: favoriteUseCase)
        return DetailView(presenter: presenter)
    }
}
