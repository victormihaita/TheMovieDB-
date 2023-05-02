//
//  MoviesView.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 01/12/2020.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel: MoviesViewModel

    private var rows: [GridItem] = [GridItem(.flexible(), spacing: 0)]

    init(type: MoviePath) {
        viewModel = MoviesViewModel(type: type)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.type.title)
                    .font(.title3)
                Spacer()
                NavigationLink(destination: MoviesOverview(type: viewModel.type)) {
                    Text("Show more")
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 16, pinnedViews: []) {
                    ForEach(viewModel.movies, id: \.id) { movie in
                        MovieCard(movie: movie)
                    }
                }
            }
        }
        .padding()
    }
}
