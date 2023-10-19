//
//  MainTabView.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI

struct MainTabView: View {
    
    let injection = Injection()
    
    var body: some View {
        TabView {
            HomeView(presenter: HomePresenter(
                homeUseCase: injection.provideHome())
            ).tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            SearchView(presenter: SearchPresenter(
                searchUseCase: injection.provideSearch())
            ).tabItem {
                Image(systemName: "magnifyingglass.circle")
                Text("Search")
            }

            FavoriteView(presenter: FavoritePresenter(
                favoriteUseCase: injection.provideFavorites())
            ).tabItem {
                Image(systemName: "heart.circle")
                Text("Favorite")
            }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
