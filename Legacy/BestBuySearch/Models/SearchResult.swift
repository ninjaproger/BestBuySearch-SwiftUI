//
//  SearchResult.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation

struct SearchResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case nextCursorMark
        case totalPages
        case total
        case queryTime
        case totalTime
        case isPartial = "partial"
        case cannonicalUrl
        case products
    }

    static let placeholder: SearchResult = .init(
        nextCursorMark: "*",
        totalPages: 0,
        total: 0,
        queryTime: 0,
        totalTime: 0,
        isPartial: false,
        cannonicalUrl: "",
        products: []
    )

    let nextCursorMark: String
    let totalPages: Int
    let total: Int
    let queryTime: TimeInterval
    let totalTime: TimeInterval
    let isPartial: Bool
    let cannonicalUrl: String?
    let products: [Product]

    init(
        nextCursorMark: String,
        totalPages: Int,
        total: Int,
        queryTime: TimeInterval,
        totalTime: TimeInterval,
        isPartial: Bool,
        cannonicalUrl: String?,
        products: [Product]
    ) {
        self.nextCursorMark = nextCursorMark
        self.totalPages = totalPages
        self.total = total
        self.queryTime = queryTime
        self.totalTime = totalTime
        self.isPartial = isPartial
        self.cannonicalUrl = cannonicalUrl
        self.products = products
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nextCursorMark = try container.decodeIfPresent(String.self, forKey: .nextCursorMark) ?? "*"
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
        total = try container.decodeIfPresent(Int.self, forKey: .total) ?? 0
        let queryTimeString: String = try container.decodeIfPresent(String.self, forKey: .queryTime) ?? "0"
        queryTime = TimeInterval(queryTimeString) ?? 0
        let totalTimeString: String = try container.decodeIfPresent(String.self, forKey: .totalTime) ?? "0"
        totalTime = TimeInterval(totalTimeString) ?? 0
        isPartial = try container.decodeIfPresent(Bool.self, forKey: .isPartial) ?? false
        cannonicalUrl = try container.decodeIfPresent(String.self, forKey: .cannonicalUrl)
        products = try container.decodeIfPresent([Product].self, forKey: .products) ?? []
    }
}
