//
//  SearchResult.swift
//  BestBuySearch
//

import Foundation

public struct SearchResult: Decodable, Sendable, Equatable {
    public enum CodingKeys: String, CodingKey {
        case nextCursorMark
        case totalPages
        case total
        case queryTime
        case totalTime
        case isPartial = "partial"
        case cannonicalUrl
        case products
    }

    public static let placeholder: SearchResult = .init(
        nextCursorMark: "*",
        totalPages: 0,
        total: 0,
        queryTime: 0,
        totalTime: 0,
        isPartial: false,
        cannonicalUrl: "",
        products: []
    )

    public let nextCursorMark: String
    public let totalPages: Int
    public let total: Int
    public let queryTime: TimeInterval
    public let totalTime: TimeInterval
    public let isPartial: Bool
    public let cannonicalUrl: String?
    public let products: [Product]

    public init(
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

    public init(from decoder: Decoder) throws {
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
