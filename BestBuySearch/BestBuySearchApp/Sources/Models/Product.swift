//
//  Product.swift
//  BestBuySearch
//

import Foundation

public struct Product: Decodable, Hashable, Sendable {
    public let name: String
    public let upc: String
    public let image: URL?
    public let salePrice: Double
    public let longDescription: String?
    public let shortDescription: String?

    public init(
        name: String,
        upc: String,
        image: URL? = nil,
        salePrice: Double,
        longDescription: String? = nil,
        shortDescription: String? = nil
    ) {
        self.name = name
        self.upc = upc
        self.image = image
        self.salePrice = salePrice
        self.longDescription = longDescription
        self.shortDescription = shortDescription
    }
}
