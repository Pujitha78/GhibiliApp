//
//  FavoriteScreen.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/21/26.
//

import SwiftUI

struct FavoritesScreen: View {
    
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    
    var films: [Film] {
       let favorites = favoritesViewModel.favoriteIDs
        switch filmsViewModel.state {
            case .loaded(let films):
                return films.filter { favorites.contains($0.id) }
            default: return []
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("No Favorites yet", systemImage: "heart")
                } else {
                    FilmsListView(films: films,
                                 favoritesViewModel: favoritesViewModel)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(filmsViewModel: FilmsViewModel.example,
                    favoritesViewModel: FavoritesViewModel.example)
}
