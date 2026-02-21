//
//  BestBuyClient.swift
//  BestBuySearch
//

import Dependencies
import DependenciesMacros
import Foundation
import Models

@DependencyClient
public struct BestBuyClient: Sendable {
    public var search: @Sendable (_ query: String, _ cursorMark: String, _ pageSize: Int) async throws -> SearchResult
}

extension BestBuyClient: DependencyKey {
    public static var liveValue: Self {
        let baseUrl = URL(string: "https://api.bestbuy.com/v1/")!
        let apiKey = "7Ob7hGyGMBma1ilGiq7tc2XZ" // From legacy code

        let session: URLSession = {
            let config = URLSessionConfiguration.default
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1
            return URLSession(configuration: config, delegate: nil, delegateQueue: queue)
        }()

        return Self(
            search: { query, cursorMark, pageSize in
                let components = query.components(separatedBy: " ").filter { !$0.isEmpty }
                let searchQuery = components.map { "search=\($0)" }.joined(separator: "&")
                let path = "products(\(searchQuery))"
                var url = baseUrl.appendingPathComponent(path)

                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
                urlComponents.queryItems = [
                    URLQueryItem(name: "format", value: "json"),
                    URLQueryItem(name: "apiKey", value: apiKey),
                    URLQueryItem(name: "cursorMark", value: cursorMark),
                    URLQueryItem(name: "pageSize", value: String(pageSize)),
                    URLQueryItem(name: "show", value: "name,upc,salePrice,image,longDescription,shortDescription")
                ]
                url = urlComponents.url!

                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let (data, _) = try await session.data(for: request)
                return try JSONDecoder().decode(SearchResult.self, from: data)
            }
        )
    }
}

extension DependencyValues {
    public var bestBuyClient: BestBuyClient {
        get { self[BestBuyClient.self] }
        set { self[BestBuyClient.self] = newValue }
    }
}
