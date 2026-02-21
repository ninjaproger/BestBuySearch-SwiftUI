//
//  SearchDataSourceType.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation

protocol SearchDataSourceType: ObservableObject {
    var searchResult: SearchResult { get }
    var isSearching: Bool { get }
    var products: [Product] { get }
    var searchText: String { get set }
    var error: Error? { get set }
    var isSearchListFull: Bool { get }

    func loadNextPage()
}
