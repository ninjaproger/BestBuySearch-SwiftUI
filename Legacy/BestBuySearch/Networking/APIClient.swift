//
//  APIClient.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation
import Combine

struct APIClient {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    static let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        // Make requests execute serially one by one instead of concurrently to prevent pagination issues
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    static let session: URLSession = URLSession(
        configuration: URLSessionConfiguration.default,
        delegate: nil,
        delegateQueue: operationQueue
    )

    func run<Model: Decodable>(_ request: URLRequest) -> AnyPublisher<Model, Error> {
        return Self.session
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Model.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func run<Model: Decodable>(_ request: URLRequest) async throws -> Model {
        let (data, _) = try await Self.session.data(for: request)
        return try JSONDecoder().decode(Model.self, from: data)
    }
}
