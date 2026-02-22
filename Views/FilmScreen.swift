//
//  FilmScreen.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/21/26.
//

import SwiftUI

struct FilmScreen: View {
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No films yet")
                case .loading:
                    ProgressView{
                        Text("Loading....")
                    }
                case .loaded(let films):
                    FilmsListView(films: films,
                                  favoritesViewModel: favoritesViewModel)
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.pink)
                }
            }
            .navigationTitle("Ghibli Movies")
        }
    }
}

#Preview {
    FilmScreen(filmsViewModel: FilmsViewModel.example,
               favoritesViewModel: FavoritesViewModel.example)
}
