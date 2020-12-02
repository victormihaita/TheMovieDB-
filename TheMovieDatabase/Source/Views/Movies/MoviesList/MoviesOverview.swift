//
//  MoviesOverview.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviesOverview: View {
    @ObservedObject var viewModel: MoviesViewModel

    private var columns: [GridItem] = [GridItem(.adaptive(minimum: 160), spacing: 16)]

    init(type: MoviePath) {
        viewModel = MoviesViewModel(type: type)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.movies, id: \.id) { movie in
                    MovieCard(movie: movie)
                        .onAppear { self.viewModel.listItemAppears(movie) }
                }
            }
        }
        .padding()
        .navigationBarTitle(viewModel.type.title)
    }
}
