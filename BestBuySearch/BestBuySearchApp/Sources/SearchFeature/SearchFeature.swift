//
//  SearchFeature.swift
//  BestBuySearch
//

import BestBuyClient
import ComposableArchitecture
import Foundation
import Models
import ProductDetailFeature
import SwiftUI

@Reducer
public struct SearchReducer: Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        public var searchText: String = ""
        public var products: [Product] = []
        public var searchResult: SearchResult = .placeholder
        public var isSearching: Bool = false
        public var isLoadingNextPage: Bool = false
        @Presents public var alert: AlertState<Never>?

        public var isSearchListFull: Bool {
            !products.isEmpty && products.count >= searchResult.total
        }

        public init(
            searchText: String = "",
            products: [Product] = [],
            searchResult: SearchResult = .placeholder,
            isSearching: Bool = false,
            isLoadingNextPage: Bool = false,
            alert: AlertState<Never>? = nil
        ) {
            self.searchText = searchText
            self.products = products
            self.searchResult = searchResult
            self.isSearching = isSearching
            self.isLoadingNextPage = isLoadingNextPage
            self.alert = alert
        }
    }

    public enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
        case searchTextDebounced
        case searchResponse(Result<SearchResult, Error>)
        case nextPageResponse(Result<SearchResult, Error>)
        case loadNextPage
        case productTapped(Product)
        case alert(PresentationAction<Never>)
    }

    @Dependency(\.bestBuyClient) var bestBuyClient
    @Dependency(\.mainQueue) var mainQueue

    private enum CancelID { case search }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.searchText):
                if state.searchText.isEmpty {
                    state.products = []
                    state.searchResult = .placeholder
                    state.isSearching = false
                    return .cancel(id: CancelID.search)
                }
                return .send(.searchTextDebounced)
                    .debounce(id: CancelID.search, for: 0.5, scheduler: mainQueue)

            case .searchTextDebounced:
                state.isSearching = true
                state.alert = nil
                return .run { [query = state.searchText] send in
                    await send(.searchResponse(Result {
                        try await bestBuyClient.search(query: query, cursorMark: "*", pageSize: 20)
                    }))
                }
                .cancellable(id: CancelID.search)

            case .searchResponse(.success(let result)):
                state.isSearching = false
                state.searchResult = result
                state.products = result.products
                return .none

            case .searchResponse(.failure(let error)):
                state.isSearching = false
                state.alert = AlertState {
                    TextState(error.localizedDescription)
                }
                return .none

            case .loadNextPage:
                guard !state.isLoadingNextPage, !state.isSearchListFull, !state.searchText.isEmpty else {
                    return .none
                }
                state.isLoadingNextPage = true
                return .run { [query = state.searchText, cursorMark = state.searchResult.nextCursorMark] send in
                    await send(.nextPageResponse(Result {
                        try await bestBuyClient.search(query: query, cursorMark: cursorMark, pageSize: 20)
                    }))
                }

            case .nextPageResponse(.success(let result)):
                state.isLoadingNextPage = false
                state.searchResult = result
                state.products.append(contentsOf: result.products)
                return .none

            case .nextPageResponse(.failure(let error)):
                state.isLoadingNextPage = false
                state.alert = AlertState {
                    TextState(error.localizedDescription)
                }
                return .none

            case .productTapped:
                return .none

            case .alert, .binding:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

public struct SearchView: View {
    @ComposableArchitecture.Bindable var store: StoreOf<SearchReducer>

    public init(store: StoreOf<SearchReducer>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                if store.products.isEmpty {
                    Text("""
                        BEST
                        BUY
                        SEARCH
                        """)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 65).weight(.bold))
                        .foregroundColor(.gray)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: -2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(store.products, id: \.self) { product in
                            Button {
                                store.send(.productTapped(product))
                            } label: {
                                ProductCell(product: product)
                            }
                            .buttonStyle(.plain)
                        }

                        if !store.isSearchListFull, !store.searchText.isEmpty {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .onAppear {
                                        store.send(.loadNextPage)
                                    }
                                Spacer()
                            }
                        }
                    }
                    .listStyle(.plain)
                }

                if store.isSearching {
                    ProgressView()
                        .scaleEffect(2)
                }
            }
            .searchable(text: $store.searchText)
            .navigationTitle("Best Buy Search")
            .alert($store.scope(state: \.alert, action: \.alert))
        }
    }
}

#Preview {
    NavigationStack {
        SearchView(
            store: Store(initialState: SearchReducer.State()) {
                SearchReducer()
            } withDependencies: {
                $0.bestBuyClient.search = { _, _, _ in .mockSearchResult }
            }
        )
    }
}

struct ProductCell: View {
    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: product.image) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            } placeholder: {
                if product.image != nil {
                    ProgressView()
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                }
            }
            .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .font(.subheadline)
                    .lineLimit(2)
                Text(product.salePrice.toCurrencyString() ?? "")
                    .font(.headline)
            }
        }
    }
}
