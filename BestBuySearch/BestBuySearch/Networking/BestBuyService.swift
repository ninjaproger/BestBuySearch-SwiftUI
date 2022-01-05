//
//  BestBuyService.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation
import Combine

// "https://api.bestbuy.com/v1/products(search=pixel&search=pen)?format=json&show=name,upc,salePrice,image,longDescription&apiKey=INSERT_API_KEY"

enum BestBuyService {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://api.bestbuy.com/v1/")!

    enum APIPath: APIPathType {
        case search(String, String, Int)

        var path: String {
            switch self {
            case .search(let searchQuery, _, _):
                let components = searchQuery.components(separatedBy: " ").filter { !$0.isEmpty }
                let query = components.map { "search=\($0)" }.joined(separator: "&")
                return "products(\(query))"
            }
        }

        var url: URL {
            baseUrl.appendingPathComponent(path)
        }

        var method: String {
            switch self {
            case .search:
                return "GET"
            }
        }

        var headerFields: [String: String] {
            return [
                "Content-Type": "application/json"
            ]
        }

        var queryParams: [String: String] {
            var queryParams: [String: String] = [
                "format": "json",
                "apiKey": "7Ob7hGyGMBma1ilGiq7tc2XZ"
            ]

            switch self {
            case .search(_, let cursorMark, let pageSize):
                queryParams["cursorMark"] = cursorMark
                queryParams["pageSize"] = String(pageSize)
                queryParams["show"] = "name,upc,salePrice,image,longDescription,shortDescription"
            }
            return queryParams
        }

        var body: Data? {
            return nil
        }
    }
}

extension BestBuyService {
    static func search(for searchText: String, cursorMark: String = "*", pageSize: Int = 20) -> AnyPublisher<SearchResult, Error> {
        apiClient.run(APIPath.search(searchText, cursorMark, pageSize).request)
            .eraseToAnyPublisher()
    }

    static func searchAsync(for searchText: String, cursorMark: String = "*", pageSize: Int = 20) async throws -> SearchResult {
        try await apiClient.run(APIPath.search(searchText, cursorMark, pageSize).request)
    }
}
