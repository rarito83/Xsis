//
//  HomeView.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @StateObject var presenter: HomePresenter
    @State private var select = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                CarauselView()
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(presenter.genreMovies, id: \.id) { genre in
                                Button {
                                    select = genre.name
                                    self.presenter.fetchMovies(id: genre.id, page: presenter.page)
                                } label: {
                                    Text("\(genre.name)")
                                        .foregroundColor(.black)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 2)
                                                .frame(width: 137, height: 33)
                                        )
                                        .padding()
                                }
                                .frame(width: 140, height: 36)
                                .cornerRadius(10)
                                .background(select == genre.name ? Color.gray : Color.white)
                                .cornerRadius(10)
                                .onAppear {
                                    if let first = presenter.genreMovies.first?.name {
                                        select = first
                                    }
                                }
                            }
                        }
                    }.padding()
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            ForEach(presenter.movies, id: \.id) { movie in
                                self.presenter.linkBuilder(for: movie) {
                                    MovieView(movie: movie)
                                }
                            }
                        }.padding(.top, 16)
                    }
                }
            }.onAppear {
                presenter.fetchGenresMovie()
                presenter.fetchMovies(id: presenter.idGenre, page: presenter.page)
            }
        }
    }
}
