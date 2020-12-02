//
//  ShowInfoViewModel.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import Foundation
import Combine

class ShowInfoViewModel: ObservableObject {
    @Published var show: Show

    private var cancellable: AnyCancellable?

    init(show: Show) {
        self.show = show
        getShow(with: "\(show.showId)")
    }

    func getShow(with id: String) {
        cancellable = ApiService.fetchShow(.show(id: id))
            .mapError { return $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.show = $0 })
    }
}
