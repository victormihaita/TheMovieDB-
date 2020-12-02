//
//  ShowsOverview.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowsOverview: View {
    @ObservedObject var viewModel: ShowsViewModel

    private var columns: [GridItem] = [GridItem(.adaptive(minimum: 160), spacing: 16)]

    init(type: ShowPath) {
        viewModel = ShowsViewModel(type: type)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.shows, id: \.id) { show in
                    ShowCard(show: show)
                        .onAppear { self.viewModel.listItemAppears(show) }
                }
            }
        }
        .padding()
        .navigationBarTitle(viewModel.type.title)
    }
}
