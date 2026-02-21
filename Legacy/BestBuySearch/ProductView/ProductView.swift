//
//  ProductView.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import SwiftUI

struct ProductView<Validator: CheckValidatorType>: View {
    let product: Product
    let checkValidator: Validator

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                AsyncImage(url: product.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)

                } placeholder: {
                    if product.image != nil {
                        ProgressView()
                    } else {
                        Image(systemName: "photo")
                            .font(.system(size: 32))
                    }
                }

                HStack {
                    Text(product.name)
                        .font(.title)
                    Spacer()
                    Text(product.salePrice.toCurrencyString() ?? "")
                        .font(.title.weight(.bold))
                }

                HStack {
                    Text("UPC: " + product.upc)
                        .font(.footnote.weight(.light))
                        .textSelection(.enabled)
                    if CheckValidator.isValid(code: product.upc) {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "xmark.octagon")
                            .foregroundColor(.red)
                    }
                    Spacer()
                }
                if let description = product.longDescription {
                    Text(description)
                        .font(.body)
                }
            }
        }
        .padding()
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            ProductView(product: Product.mockProduct, checkValidator: CheckValidator())
                .padding()
        }
    }
}
