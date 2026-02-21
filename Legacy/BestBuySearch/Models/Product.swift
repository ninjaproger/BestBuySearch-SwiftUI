//
//  Product.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation

struct Product: Decodable, Hashable {
    let name: String
    let upc: String
    let image: URL?
    let salePrice: Double
    let longDescription: String?
    let shortDescription: String?
}
