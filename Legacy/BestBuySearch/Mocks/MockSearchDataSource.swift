//
//  MockSearchDataSource.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation

final class MockSearchDataSource: SearchDataSourceType {
    var isSearchListFull: Bool = true
    var searchResult: SearchResult = .mockSearchResult
    var isSearching: Bool = false
    var products: [Product] {
        searchResult.products
    }
    var searchText: String = "flash"
    var error: Error?

    func loadNextPage() {}
}
