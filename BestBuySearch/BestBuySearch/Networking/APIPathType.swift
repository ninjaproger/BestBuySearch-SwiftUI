//
//  APIPathType.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation

protocol APIPathType {
    var path: String { get }
    var url: URL { get }
    var method: String { get }
    var request: URLRequest { get }
    var headerFields: [String: String] { get }
    var body: Data? { get }
    var queryParams: [String: String] { get }
}

extension APIPathType {
    var request: URLRequest {
        var url = url
        queryParams.forEach {
            url = url.appending($0.key, value: $0.value)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        headerFields.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        request.httpBody = body
        return request
    }
}
