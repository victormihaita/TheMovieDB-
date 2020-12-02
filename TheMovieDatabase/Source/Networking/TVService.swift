//
//  TVService.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import Foundation
import Combine

enum ShowPath {
    case popularTV
    case topRatedTV
    case airingTodayTV
    case onAirTV
    case show(id: String)

    var title: String {
        switch self {
        case .popularTV:
            return "Popular"
        case .topRatedTV:
            return "Top Rated"
        case .airingTodayTV:
            return "Airing Today"
        case .onAirTV:
            return "On Air"
        default:
            return ""
        }
    }

    var tvShowsOverviewPath: String {
        switch self {
        case .popularTV:
            return "tv/popular"
        case .topRatedTV:
            return "tv/top_rated"
        case .airingTodayTV:
            return "tv/airing_today"
        case .onAirTV:
            return "tv/on_the_air"
        default:
            //THIS WILL THROW ERROR
            return "NOT_SUPPORTED"
        }
    }

    var showPath: String {
        switch self {
        case .show(id: let id):
            return "tv/\(id)"
        default:
            //THIS WILL THROW ERROR
            return "NOT_SUPPORTED"
        }
    }
}

extension ApiService {
    static func fetchTVShows(_ path: ShowPath, page: Int) -> AnyPublisher<ShowsResponse, Error> {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.tvShowsOverviewPath), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "api_key", value: "1cc18d32d8a1c097a85f6150af803294"),
                                 URLQueryItem(name: "page", value: "\(page)")]
        let request = URLRequest(url: components.url!)

        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    static func fetchShow(_ path: ShowPath) -> AnyPublisher<Show, Error> {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.showPath), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "api_key", value: "1cc18d32d8a1c097a85f6150af803294")]
        return apiClient.run(URLRequest(url: components.url!))
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
