//
//  ShowsViewModel.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import Foundation
import Combine

class ShowsViewModel: ObservableObject {
    @Published var shows: [Show] = []
    @Published var type: ShowPath!

    private var cancellable: AnyCancellable?
    private var page: Int = 1
    private var isLoading: Bool = false

    init(type: ShowPath) {
        self.type = type
        getShows()
    }

    func getShows() {
        isLoading = true
        cancellable = ApiService.fetchTVShows(type, page: page)
            .mapError({ (error) -> Error in
                self.isLoading = false
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: {
                self.isLoading = false
                self.shows.append(contentsOf: $0.shows)
            })
    }

    func listItemAppears(_ show: Show) {
        guard shows.last?.id == show.id else { return }
        guard isLoading == false else { return }
        guard shows.last?.id == show.id else { return }
        DispatchQueue.main.async {
            self.page += 1
            self.getShows()
        }
    }
}
