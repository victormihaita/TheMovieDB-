//
//  TheMovieDatabaseApp.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 01/12/2020.
//

import SwiftUI

@main
struct TheMovieDatabaseApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MoviesLandingView()
                    .tabItem { Image(systemName: "film") }

                TVLandingView()
                    .tabItem { Image(systemName: "tv") }
            }
        }
    }
}
