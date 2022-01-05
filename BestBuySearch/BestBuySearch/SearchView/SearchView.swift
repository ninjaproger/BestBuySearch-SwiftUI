//
//  SearchView.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Combine
import SwiftUI

struct SearchView<DataSource: SearchDataSourceType>: View {
    @StateObject var dataSource: DataSource
    @EnvironmentObject var validator: CheckValidator

    var body: some View {
        NavigationView {
            ZStack {
                if dataSource.products.isEmpty {
                    Text("Best\nBuy\nSearch".uppercased())
                        .multilineTextAlignment(.center)
                        .font(.system(size: 65).weight(.bold))
                        .foregroundColor(.gray)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: -2)

                } else {
                    List {
                        ForEach(dataSource.products, id: \.self) { product in
                            NavigationLink(
                                destination: ProductView(
                                    product: product,
                                    checkValidator: validator
                                )
                            ) {
                                ProductCell(product: product)
                            }
                        }
                        if !dataSource.isSearchListFull, !dataSource.searchText.isEmpty {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .onAppear {
                                        dataSource.loadNextPage()
                                    }
                                Spacer()
                            }
                        }
                    }
                }
                if dataSource.isSearching {
                    VStack {
                        ProgressView()
                            .opacity(dataSource.isSearching ? 1 : 0)
                            .scaleEffect(2)
                    }
                }
            }
            .searchable(text: $dataSource.searchText)
            .navigationTitle("Best Buy Search")
        }
        .alert(isPresented: Binding<Bool>(get: {
            self.dataSource.error != nil
        }, set: { _ in
            self.dataSource.error = nil
        })) {
            Alert(
                title: Text(self.dataSource.error!.localizedDescription),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            SearchView(dataSource: MockSearchDataSource())
        }
    }
}
