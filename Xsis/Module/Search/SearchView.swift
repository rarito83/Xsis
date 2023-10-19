//
//  SearchView.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI

struct SearchView: View {

    @StateObject var presenter: SearchPresenter
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(presenter.movies, id: \.id) { movie in
                    self.presenter.linkBuilder(for: movie) {
                        MovieView(movie: movie)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Search Movies")
            .onSubmit(of: .search) {
                Task {
                    presenter.searchMovie(text: searchText)
                    searchText = ""
                }
            }
        }
//        .accentColor(.yellow)
    }
}
