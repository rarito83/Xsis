//
//  IsFavoriteView.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI

struct IsFavoriteView: View {
    var image: String
    var title: String
    var isFavorite: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                .frame(width: 260, height: 40)
            
            HStack {
                Image(systemName: image)
                    .font(.system(size: 20))
                    .foregroundColor(isFavorite ? Color.red : Color.green)
                
                Text(title)
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
        }
    }
}

struct IsFavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        IsFavoriteView(image: "heart.fill", title: "favorite", isFavorite: true)
    }
}
