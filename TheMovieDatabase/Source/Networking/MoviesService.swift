//
//  MovieDBApi.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 01/12/2020.
//

import Foundation
import Combine

enum ApiService {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://api.themoviedb.org/3/")!
}

enum MoviePath {
    case trendingMoviesWeekly
    case topRated
    case popularMovies
    case moviesInTheatre
    case upcoming
    case movie(id: String)

    var title: String {
        switch self {
        case .moviesInTheatre:
            return "In Theatre"
        case .popularMovies:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .trendingMoviesWeekly:
            return "Trending This Week"
        case .upcoming:
            return  "Upcoming"
        default:
            return ""
        }
    }

    var moviesOverviewPath: String {
        switch self {
        case .moviesInTheatre:
            return "trending/movie/week"
        case .popularMovies:
            return "movie/top_rated"
        case .topRated:
            return "movie/popular"
        case .trendingMoviesWeekly:
            return "movie/now_playing"
        case .upcoming:
            return "movie/upcoming"
        default:
            //THIS WILL THROW ERROR
            return "NOT_SUPPORTED"
        }
    }

    var moviePath: String {
        switch self {
        case .movie(id: let id):
            return "movie/\(id)"
        default:
            //THIS WILL THROW ERROR
            return "NOT_SUPPORTED"
        }
    }
}

extension ApiService {
    static func fetchMovies(_ path: MoviePath, page: Int) -> AnyPublisher<MoviesResponse, Error> {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.moviesOverviewPath), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "api_key", value: "1cc18d32d8a1c097a85f6150af803294"),
                                 URLQueryItem(name: "page", value: "\(page)")]
        let request = URLRequest(url: components.url!)

        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    static func fetchMovie(_ path: MoviePath) -> AnyPublisher<Movie, Error> {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.moviePath), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "api_key", value: "1cc18d32d8a1c097a85f6150af803294")]
        return apiClient.run(URLRequest(url: components.url!))
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
