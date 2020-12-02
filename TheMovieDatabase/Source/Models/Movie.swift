//
//  Movie.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 01/12/2020.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
}

struct Movie: Codable, Identifiable {
    var id = UUID()
    let posterPath: String?
    let overview: String
    let movieId: Int
    let title: String
    let voteAverage: Double
    let tagline: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case movieId = "id"
        case voteAverage = "vote_average"
        case overview
        case title
        case tagline
    }

    enum PosterQuality {
        case low
        case regular
        case high
    }

    func getPosterUrl(_ posterQuality: PosterQuality) -> URL {
        var quality: String {
            switch posterQuality {
            case .low:
                return "w185"
            case .regular:
                return "ww342"
            case .high:
                return "original"
            }
        }
        return URL(string: "http://image.tmdb.org/t/p/\(quality)\(posterPath ?? "")")!
    }

    func getVoteAverage() -> String {
        return String(format: "%.1f", voteAverage)
    }
}

struct MoviesResponse: Codable {
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
