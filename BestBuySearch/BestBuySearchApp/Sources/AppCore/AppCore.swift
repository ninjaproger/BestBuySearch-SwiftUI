//
//  AppCore.swift
//  BestBuySearch
//

import ComposableArchitecture
import Foundation
import Models
import ProductDetailFeature
import SearchFeature
import SwiftUI

@Reducer
public struct AppCoreReducer: Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        public var search = SearchReducer.State()
        public var path = StackState<Path.State>()
        public init() {}
    }

    public enum Action: Sendable {
        case search(SearchReducer.Action)
        case path(StackAction<Path.State, Path.Action>)
    }

    @Reducer
    public enum Path: Sendable {
        case productDetail(ProductDetailReducer)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(state: \.search, action: \.search) {
            SearchReducer()
        }

        Reduce { state, action in
            switch action {
            case .search(.productTapped(let product)):
                state.path.append(.productDetail(ProductDetailReducer.State(product: product)))
                return .none
            case .search, .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension AppCoreReducer.Path.State: Equatable {}

public struct AppCoreView: View {
    @ComposableArchitecture.Bindable var store: StoreOf<AppCoreReducer>

    public init(store: StoreOf<AppCoreReducer>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                SearchView(store: store.scope(state: \.search, action: \.search))
            } destination: { store in
                switch store.case {
                case .productDetail(let store):
                    ProductDetailView(store: store)
                }
            }
        }
    }
}
