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

    @State var columns: Int = 2

    init(type: ShowPath) {
        viewModel = ShowsViewModel(type: type)
    }

    var body: some View {
        StaggeredGrid(columns: columns, spacing: 32, list: viewModel.shows) { show in
            ShowCardGridView(show: show)
                .onAppear { self.viewModel.listItemAppears(show) }
        }
        .padding(.horizontal)
        .navigationBarTitle(viewModel.type.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    guard columns <= 2 else { return }
                    columns += 1
                } label: {
                    Image(systemName: "plus")
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    guard columns > 1 else { return }
                    columns -= 1
                } label: {
                    Image(systemName: "minus")
                }
            }
        }
    }
}

struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    var content: (T) -> Content

    var list: [T]

    var showsIndicators: Bool

    var spacing: CGFloat

    var columns: Int

    init(columns: Int = 2, showsIndicators: Bool = false, spacing: CGFloat = 8, list: [T], @ViewBuilder content: @escaping (T)->Content) {
        self.content = content
        self.list = list
        self.showsIndicators = showsIndicators
        self.spacing = spacing
        self.columns = columns
    }

    func setUpList()-> [[T]] {
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        var currentIndex = 0

        for object in list {
            gridArray[currentIndex].append(object)

            if currentIndex == columns - 1 {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        return gridArray
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: showsIndicators) {
            HStack(alignment: .top) {
                ForEach(setUpList(), id: \.self) { columnsData in
                    LazyVStack(spacing: spacing) {
                        ForEach(columnsData) { object in
                            content(object)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
