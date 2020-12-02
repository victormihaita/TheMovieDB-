//
//  TVShow.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import Foundation

struct Show: Codable, Identifiable {
    var id = UUID()
    let posterPath: String?
    let overview: String?
    let showId: Int
    let name: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case showId = "id"
        case voteAverage = "vote_average"
        case overview
        case name
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

struct ShowsResponse: Codable {
    let shows: [Show]

    enum CodingKeys: String, CodingKey {
        case shows = "results"
    }
}
