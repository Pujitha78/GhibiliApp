//
//  ContentView.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/20/26.
//

import SwiftUI

struct ContentView: View {
    @State var filmsViewModel = FilmsViewModel()
    @State var favoritesViewModel = FavoritesViewModel()
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper"){
                FilmScreen(filmsViewModel: filmsViewModel,
                           favoritesViewModel: favoritesViewModel)
            }
            Tab("Favorites", systemImage: "heart"){
                FavoritesScreen(filmsViewModel: filmsViewModel,
                                favoritesViewModel: favoritesViewModel)
            }
            Tab("Settings", systemImage: "gear"){
                SettingsScreen()
            }
            Tab(role: .search){
                SearchScreen(favoritesViewModel: favoritesViewModel)
            }
        }
        .task {
            favoritesViewModel.load()
            await filmsViewModel.fetch()
        }
        .setAppearanceTheme()
    }
}

#Preview {
    ContentView()
}
