//
//  MovieInfoViewModel.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import Foundation
import Combine

class MovieInfoViewModel: ObservableObject {
    @Published var movie: Movie

    private var cancellable: AnyCancellable?

    init(movie: Movie) {
        self.movie = movie
        getMovie(with: "\(movie.movieId)")
    }

    func getMovie(with id: String) {
        cancellable = ApiService.fetchMovie(.movie(id: id))
            .mapError { return $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.movie = $0 })
    }
}
