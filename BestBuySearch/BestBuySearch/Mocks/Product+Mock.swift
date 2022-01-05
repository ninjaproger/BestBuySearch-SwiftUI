//
//  Product+Mock.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation

extension Product {
    static let mockProduct: Product = {
        let jsonString = """
            {
                "name": "Energizer - TAC-R 700 Rechargeable Flashlight - Black",
                "upc": "039800133458",
                "salePrice": 34.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6355/6355649_sd.jpg",
                "longDescription": "You're ready for action with the Energizer TAC-R-700 Rechargeable Flashlight. This rechargeable LED flashlight runs for up to 30 hours on low mode for light you can count on. The rechargeable flashlight keeps shining under tough conditions with IPX4 water-resistance, an aircraft-grade aluminum body and a strike bezel head. Up to 15X brighter than standard LED technology, this Energizer flashlight throws off 700 lumens&#8212;bright enough for DIY projects and outdoor activities such as camping. Control the amount of light with four modes, including Strobe for emergency situations. A rear push button lets you easily change the mode while holding this Energizer LED flashlight, and a removable clip that works in both orientations secures to your pocket or bag. This rechargeable LED flashlight includes a USB charging cable for ready use. Trust Energizer for the brightness and dependability you need from a rechargeable battery powered flashlight."
            }
    """
        let data = jsonString.data(using: .utf8)!
        let mockProduct = try! JSONDecoder().decode(Product.self, from: data)
        return mockProduct
    }()
}
