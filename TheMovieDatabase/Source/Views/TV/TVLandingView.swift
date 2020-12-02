//
//  TVLandingView.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import SwiftUI

struct TVLandingView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ShowsView(type: .popularTV)
                ShowsView(type: .onAirTV)
                ShowsView(type: .topRatedTV)
                ShowsView(type: .airingTodayTV)
            }
            .navigationBarTitle("TV Series")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
