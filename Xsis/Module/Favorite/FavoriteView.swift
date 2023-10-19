//
//  FavoriteView.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {
    
    @StateObject var presenter: FavoritePresenter
    
    var body: some View {
        NavigationStack {
            VStack {
                if presenter.loadingState {
                    VStack {
                        ProgressView().padding()
                        Text("Loading...")
                    }
                } else if !presenter.movies.isEmpty {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            ForEach(presenter.movies, id: \.id) { movie in
                                self.presenter.linkBuilder(for: movie) {
                                    MovieView(movie: movie)
                                }
                            }
                        }.padding(.top, 16)
                    }
                } else if presenter.movies.isEmpty {
                    EmptyView(image: "film.fill", title: "Anda belum menambahkan movie favorit")
                } else {
                    Text(presenter.errorMessage)
                }
            }.onAppear {
                self.presenter.fetchMovies()
            }
            .navigationTitle("Favorite Movies")
        }
    }
}
