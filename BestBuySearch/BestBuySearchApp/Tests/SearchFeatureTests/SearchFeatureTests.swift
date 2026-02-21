//
//  SearchFeatureTests.swift
//  SearchFeatureTests
//

import ComposableArchitecture
import Models
import XCTest
@testable import SearchFeature

@MainActor
final class SearchFeatureTests: XCTestCase {
    func testSearchDebounce() async {
        let store = TestStore(initialState: SearchReducer.State()) {
            SearchReducer()
        } withDependencies: {
            $0.mainQueue = .immediate
            $0.bestBuyClient.search = { _, _, _ in .mockSearchResult }
        }

        await store.send(.binding(.set(\.searchText, "pixel"))) {
            $0.searchText = "pixel"
        }
        
        await store.receive(\.searchTextDebounced) {
            $0.isSearching = true
        }
        
        await store.receive(\.searchResponse.success) {
            $0.isSearching = false
            $0.searchResult = .mockSearchResult
            $0.products = SearchResult.mockSearchResult.products
        }
    }
    
    func testClearSearch() async {
        let store = TestStore(initialState: SearchReducer.State(
            searchText: "pixel",
            products: SearchResult.mockSearchResult.products,
            searchResult: .mockSearchResult
        )) {
            SearchReducer()
        }
        
        await store.send(.binding(.set(\.searchText, ""))) {
            $0.searchText = ""
            $0.products = []
            $0.searchResult = SearchResult.placeholder
            $0.isSearching = false
        }
    }
}
