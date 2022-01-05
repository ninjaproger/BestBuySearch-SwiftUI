//
//  SearchDataSource.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Combine
import Foundation

final class SearchDataSource: SearchDataSourceType {
    @Published private (set) var searchResult: SearchResult = .placeholder
    @Published private (set) var isSearching: Bool = false
    @Published var searchText: String = ""
    @Published var error: Error?

    var isSearchListFull: Bool {
        products.count >= searchResult.total
    }

    var canLoadNextPage: Bool {
        !isSearching &&
        !isSearchListFull &&
        !searchText.isEmpty
    }

    private (set) var products: [Product] = []
    private var tokens: Set<AnyCancellable> = .init()

    init() {
        bind()
    }

    func loadNextPage() {
        guard canLoadNextPage else {
            return
        }
        query(searchText, replaceProducts: false)
    }

    private func bind() {
        $searchText
            .dropFirst()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [unowned self] searchText in
                self.searchResult = .placeholder
                guard !searchText.isEmpty else {
                    return
                }
                self.isSearching = true
                self.query(searchText)
            }
            .store(in: &tokens)
    }

    private func query(_ searchText: String, replaceProducts: Bool = true) {
        BestBuyService.search(for: searchText, cursorMark: searchResult.nextCursorMark)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.isSearching = false
                switch result {
                case .failure(let error):
                    self?.searchResult = .placeholder
                    self?.error = error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                self?.searchResult = result
                if replaceProducts {
                    self?.products = result.products
                } else {
                    self?.products.append(contentsOf: result.products)
                }
            }
            .store(in: &tokens)
    }
}
