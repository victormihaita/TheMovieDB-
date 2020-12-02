//
//  MoviesLandingView.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 01/12/2020.
//

import SwiftUI

struct MoviesLandingView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                MoviesView(type: .moviesInTheatre)
                MoviesView(type: .popularMovies)
                MoviesView(type: .topRated)
                MoviesView(type: .trendingMoviesWeekly)
                MoviesView(type: .upcoming)
            }
            .navigationBarTitle("Movies")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
