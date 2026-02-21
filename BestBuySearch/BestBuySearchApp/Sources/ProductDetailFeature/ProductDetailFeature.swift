//
//  ProductDetailFeature.swift
//  BestBuySearch
//

import ComposableArchitecture
import Foundation
import Models
import SwiftUI

@Reducer
public struct ProductDetailReducer: Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        public let product: Product
        public init(product: Product) {
            self.product = product
        }
    }

    public enum Action: Sendable {
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}

public struct ProductDetailView: View {
    let store: StoreOf<ProductDetailReducer>

    public init(store: StoreOf<ProductDetailReducer>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 15) {
                    AsyncImage(url: store.product.image) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                    } placeholder: {
                        if store.product.image != nil {
                            ProgressView()
                        } else {
                            Image(systemName: "photo")
                                .font(.system(size: 32))
                        }
                    }

                    HStack {
                        Text(store.product.name)
                            .font(.title)
                        Spacer()
                        Text(store.product.salePrice.toCurrencyString() ?? "")
                            .font(.title.weight(.bold))
                    }

                    HStack {
                        Text("UPC: " + store.product.upc)
                            .font(.footnote.weight(.light))
                            .textSelection(.enabled)
                        if CheckValidator.isValid(code: store.product.upc) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "xmark.octagon")
                                .foregroundColor(.red)
                        }
                        Spacer()
                    }
                    if let description = store.product.longDescription {
                        Text(description)
                            .font(.body)
                    }
                }
            }
            .padding()
            .navigationTitle(store.product.name)
        }
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(
            store: Store(initialState: ProductDetailReducer.State(product: .mockProduct)) {
                ProductDetailReducer()
            }
        )
    }
}


