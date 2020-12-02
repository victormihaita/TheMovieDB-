//
//  ShowsView.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import SwiftUI

struct ShowsView: View {
    @ObservedObject var viewModel: ShowsViewModel

    private var rows: [GridItem] = [GridItem(.fixed(200), spacing: 0)]

    init(type: ShowPath) {
        viewModel = ShowsViewModel(type: type)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.type.title)
                    .font(.title3)
                Spacer()
                NavigationLink(destination: ShowsOverview(type: viewModel.type)) {
                    Text("Show more")
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 16, pinnedViews: []) {
                    ForEach(viewModel.shows, id: \.id) { show in
                        ShowCard(show: show)
                    }
                }
            }
        }
        .padding()
    }
}
