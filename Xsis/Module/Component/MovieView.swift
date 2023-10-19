//
//  MovieView.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieView: View {
    var movie: MovieModel
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            HStack(alignment: .top) {
                WebImage(url: URL(string: movie.poster))
                    .resizable()
                    .indicator(.activity)
                    .cornerRadius(18)
                    .frame(width: 90, height: 120)
                    .offset(x: 0, y: -30)
                    .padding(.leading, 16)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(movie.title)
                        .font(.system(size: 14, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .lineLimit(2)
                    
                    Text(movie.releaseDateFormatted)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(movie.overview)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    Spacer()
                }
                .padding(.top, 4)
                
                Spacer()
                
                RatingView(movie.voteAverage)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
            }
        }
        .frame(height: 120)
        .padding(.top, 20)
    }
}
