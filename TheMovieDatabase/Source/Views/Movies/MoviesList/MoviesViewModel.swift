//
//  MoviesViewModel.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 01/12/2020.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var type: MoviePath!

    private var cancellable: AnyCancellable?
    private var page: Int = 1
    private var isLoading: Bool = false

    init(type: MoviePath) {
        self.type = type
        getMovies()
    }

    func getMovies() {
        isLoading = true
        cancellable = ApiService.fetchMovies(type, page: page)
            .mapError({ (error) -> Error in
                self.isLoading = false
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: {
                self.isLoading = false
                self.movies.append(contentsOf: $0.movies)
            })
    }

    func listItemAppears(_ movie: Movie) {
        guard movies.last?.id == movie.id else { return }
        guard isLoading == false else { return }
        guard movies.last?.id == movie.id else { return }
        DispatchQueue.main.async {
            self.page += 1
            self.getMovies()
        }
    }
}
