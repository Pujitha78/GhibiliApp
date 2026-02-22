//
//  FilmsListView.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/20/26.
//
import SwiftUI

struct FilmsListView: View {
    var films: [Film] = []
    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                FilmRow(film: film,
                        favoritesViewModel: favoritesViewModel)
            }
        }
        .navigationDestination(for: Film.self) { film in FilmDetailsView(film: film,
                            favoritesViewModel: favoritesViewModel)
        }
    }
}

private struct FilmRow: View {
    var film: Film
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            FilmImageView(urlPath: film.image)
                .frame(width: 100, height: 150)
            VStack(alignment: .leading) {
                HStack {
                    Text(film.title)
                        .font(.headline)
                    Spacer()
                    
                    FavoriteButton(filmID: film.id,
                                   favoritesViewModel: favoritesViewModel)
                    .buttonStyle(.plain)
                    .controlSize(.large)
                }
                .padding(.bottom, 5)
                
                Text("Directed by \(film.director)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Released: \(film.releaseYear)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.top)
        }
    }
}

#Preview {
    //@State @Previewable var filmsViewModel = FilmsViewModel(service: MockGhibliService())
    @State @Previewable var favorites = FavoritesViewModel(service: MockFavoriteStorage())
    NavigationStack {
        FilmsListView(films: [Film.example], favoritesViewModel: FavoritesViewModel.example)
    }
    .task {
        favorites.load()
    }
}
