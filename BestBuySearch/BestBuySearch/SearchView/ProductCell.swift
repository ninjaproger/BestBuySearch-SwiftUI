//
//  ProductCell.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import SwiftUI

struct ProductCell: View {
    let product: Product

    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: product.image) { image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                if product.image != nil {
                    ProgressView()
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 32))
                }
            }
            .frame(width: 100, height: 100)

            Spacer()
                .frame(width: 10)

            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .font(Font.system(size: 14).weight(.semibold))

                if let description = product.shortDescription {
                    Text(description)
                        .font(Font.system(size: 9).weight(.light))
                }
            }
            .lineLimit(4)
            .multilineTextAlignment(.leading)

            Spacer()
            Text(product.salePrice.toCurrencyString() ?? "")
                .font(Font.headline)

        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            ProductCell(product: Product.mockProduct)
                .padding()
        }
    }
}
