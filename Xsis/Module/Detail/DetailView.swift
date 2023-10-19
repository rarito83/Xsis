//
//  DetailView.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit

struct DetailView: View {
    
    @StateObject var presenter: DetailPresenter
    
    var body: some View {
        ZStack {
            if presenter.detailMovie.title.isEmpty {
                VStack {
                    ProgressView().padding()
                    Text("Loading...")
                }
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    let detail = presenter.detailMovie
                    VStack {
                        WebImage(url: URL(string: detail.poster))
                            .aspectRatio(contentMode: .fill)
                            .background(Color.green)
                            .frame(width: 400, height: 220)
                            .clipped()
                            .scaledToFill()
                        
                        HStack {
                            VStack {
                                Text(detail.title)
                                    .fontWeight(.heavy)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                                
                                Text(detail.releaseDate)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Rating")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                                Text(String(detail.voteAverage))
                            }
                            .padding(.horizontal)
                        }
                        
                        if presenter.isFavorite {
                            IsFavoriteView(
                                image: "heart.fill",
                                title: "Remove from favorite",
                                isFavorite: presenter.isFavorite
                            )
                            .foregroundColor(.red)
                            .onTapGesture {
                                presenter.removeFavorite()
                            }
                        } else {
                            IsFavoriteView(
                                image: "heart",
                                title: "Add to favorite",
                                isFavorite: presenter.isFavorite
                            )
                            .foregroundColor(.green)
                            .onTapGesture {
                                presenter.addFavorite()
                            }
                        }
                        
                        Spacer()
                        
                        Text("Description")
                            .fontWeight(.heavy)
                            .font(.title2)
                            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                        Spacer()
                        
                        Text(detail.overview)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text("Genre")
                                        .fontWeight(.bold)
                                    
                                    Text(detail.genre)
                                    
                                    Text("Production")
                                        .fontWeight(.bold)
                                        .padding(.top)
                                    
                                    Text(detail.prodCompany)
                                    
                                    Text("Trailer")
                                        .fontWeight(.bold)
                                        .padding(.top)
                                    
                                    TrailerView(presenter: presenter, link: presenter.videoMovie ?? "")
                                        .frame(width: UIScreen.main.bounds.width - 24, height: 200, alignment: .center)
                                        .cornerRadius(10)
                                    
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                        }
                        .onAppear {
                            presenter.fetchMovieTrailer(id: presenter.detailMovie.id)
                        }
                    }
                }.padding(.bottom, 20)
            }
        }.onAppear {
            presenter.fetchDetailMovie()
            presenter.checkFavorite()
        }
    }
}

struct TrailerView: View {
    @ObservedObject var presenter: DetailPresenter
    @State var link: String = ""
    
    init(presenter: DetailPresenter, link: String) {
        self.presenter = presenter
        self.link = link
        print("link trailer", link)
    }
    
    var body: some View {
        VStack {
            VideoPlayer(player: AVPlayer(url: URL(
                string: "https://media.w3.org/2010/05/sintel/trailer.mp4")!
            )
            )
        }
    }
}

