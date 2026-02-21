//
//  FilmsListView.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/20/26.
//
import SwiftUI

struct FilmsListView: View {
    @State private var viewModel = FilmsViewModel()
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .idle:
                Text("No films yet")
            case .loading:
                ProgressView{
                    Text("Loading....")
                }
            case .loaded(let films):
                List(films) {
                    Text($0.title)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.pink)
            }
        }
        .task {
            await viewModel.fetch()
        }
        
    }
}

#Preview {
    FilmsListView()
}
