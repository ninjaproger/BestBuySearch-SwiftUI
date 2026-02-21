//
//  SearchResult+Mock.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import Foundation

extension SearchResult {
    static let mockSearchResult: SearchResult = {
        let jsonString = """
    {
        "from": 1,
        "to": 10,
        "currentPage": 1,
        "total": 526,
        "totalPages": 53,
        "queryTime": "0.020",
        "totalTime": "0.029",
        "partial": false,
        "products": [
            {
                "name": "Energizer - TAC-R 700 Rechargeable Flashlight - Black",
                "upc": "039800133458",
                "salePrice": 34.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6355/6355649_sd.jpg",
                "longDescription": "You're ready for action with the Energizer TAC-R-700 Rechargeable Flashlight. This rechargeable LED flashlight runs for up to 30 hours on low mode for light you can count on. The rechargeable flashlight keeps shining under tough conditions with IPX4 water-resistance, an aircraft-grade aluminum body and a strike bezel head. Up to 15X brighter than standard LED technology, this Energizer flashlight throws off 700 lumens&#8212;bright enough for DIY projects and outdoor activities such as camping. Control the amount of light with four modes, including Strobe for emergency situations. A rear push button lets you easily change the mode while holding this Energizer LED flashlight, and a removable clip that works in both orientations secures to your pocket or bag. This rechargeable LED flashlight includes a USB charging cable for ready use. Trust Energizer for the brightness and dependability you need from a rechargeable battery powered flashlight."
            },
            {
                "name": "Dark Energy - Plasma Flashlight Lighter",
                "upc": "860000725835",
                "salePrice": 29.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6446/6446793_sd.jpg",
                "longDescription": "Light your bonfires with this Dark Energy plasma lighter. The weather-resistant construction offers lasting outdoor use, while the dual-arc plasma emitters easily ignite flames, even in windy environments. USB compatibility enables easy recharges. This Dark Energy plasma lighter features a built-in flashlight for clear illumination in the dark and a strobe to enhance security on night adventures."
            },
            {
                "name": "Panther Vision - FLATEYE LED 250 Lumen Rechargeable Flashlight",
                "upc": "811465008049",
                "salePrice": 34.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6470/6470653_sd.jpg",
                "longDescription": "Panther Vision's newest 250 lumen LED FLATEYE flashlight encased in a patented UNROUND pistol grip, making it incredibly easy to hold, fit in your pocket and the perfect flashlight for all your everyday needs. FLATEYE flashlights are purposely engineered to exacting standards and crafted from aircraft grade aluminum and tactical polymer for lasting durability. They are waterproof and feature shockproof LED's for unsurpassed performance. With a choice of 2 models ranging from 150 lumens to 250 lumens, featuring a rechargeable battery with high, medium and low settings, you can get the right light and battery life for your every need. Join the UNROUND revolution and never see flashlights the same again."
            },
            {
                "name": "Panther Vision - FLATEYE LED 150 Lumen Rechargeable Flashlight",
                "upc": "811465008032",
                "salePrice": 27.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6470/6470662_sd.jpg",
                "longDescription": "Panther Vision's newest 150 lumen LED FLATEYE flashlight encased in a patented UNROUND pistol grip, making it incredibly easy to hold, fit in your pocket and the perfect flashlight for all your everyday needs. FLATEYE flashlights are purposely engineered to exacting standards and crafted from aircraft grade aluminum and tactical polymer for lasting durability. They are waterproof and feature shockproof LED's for unsurpassed performance. With a choice of 2 models ranging from 150 lumens to 250 lumens, featuring a rechargeable battery with high, medium and low settings, you can get the right light and battery life for your every need. Join the UNROUND revolution and never see flashlights the same again."
            },
            {
                "name": "Police Security - Dover 800 Lumen Rechargeable Flashlight - Black",
                "upc": "704673982952",
                "salePrice": 39.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6474/6474820_sd.jpg",
                "longDescription": "Police Security&#8217;s Dover rechargeable, 800 lumen LED flashlight, is optimal for automotive technicians and other professionals who demand long-term flashlight performance. With our Quik Connect USB charging system (cable included), this light functions with an 18650 rechargeable lithium-ion battery delivering up to 6 hours runtime. With high, low, flash modes and slide focus, this flashlight is immediately adaptable to a variety of situations."
            },
            {
                "name": "Eton - American Red Cross Blackout Buddy 50 Lumens Flashlight",
                "upc": "750254810664",
                "salePrice": 12.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6484/6484007_sd.jpg",
                "longDescription": "The innovative Eton American Red Cross Blackout Buddy Color Nightlight is an emergency LED blackout flashlight that doubles as a motion-activated nightlight. A bright emergency LED automatically lights up if you experience a power failure or blackout. When it's time to sleep, the nightlight automatically fades off, but should you get out of bed the intelligent motion sensor will turn the light back on to illuminate your path. Choose from blue, white and green for the color that best suits your space and taste. Simply plug the easy-to-install compact nightlight in and leave it in place for light whenever you need it. Slim and sleek, the Blackout Buddy is an ideal choice for hallways, bedrooms, bathrooms and more. For added utility, fold-up prongs make it easy to use this light as a super-bright LED flashlight with up to four hours of power when fully charged. The Eton Blackout Buddy Color (ARCBB203C-SNG) is an official licensed product of the American Red Cross."
            },
            {
                "name": "Eton - American Red Cross Blackout Buddy Connect 50 Lumens Flashlight",
                "upc": "750254811029",
                "salePrice": 27.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6484/6484006_sd.jpg",
                "longDescription": "Whether you're at home or away, you can experience peace of mind with the Eton American Red Cross Wi-Fi Blackout Buddy Connect Color Nightlight. The motion-activated LED nightlight pairs with your smart device using Wi-Fi and works with the Eton Smart App. With the app, you can control the color of the light and set up notifications to alert you to motion in your home, power outages or loss of your Wi-Fi network. You can also add it into your smart home automated Routines. This smart light works with Amazon Alexa and Google Assistant for seamless integration with your smart home hub. In addition to push alerts, a bright emergency LED automatically lights up when there is a power failure or blackout. A versatile choice, the Blackout Buddy offers a large selection of customizable colors, so you can choose the hue that best suits your preference or decor. When it's time to sleep the nightlight automatically fades off, and if you get out of bed the intelligent motion sensor will turn it on to illuminate your path. Simply plug this easy-to-install compact nightlight in and leave it in place for light whenever you need it. The slim and sleek design is an ideal choice for hallways, bedrooms, bathrooms and more. For added utility, fold-up prongs make it easy to use this light as a super-bright 50-lumen LED flashlight with up to four hours of power when fully charged. The Eton Blackout Buddy Connect Color (ARCBB203C-SNG) is an official licensed product of the American Red Cross."
            },
            {
                "name": "Renogy - E.LUMEN 500 Multi-functional Solar Flashlight - Black",
                "upc": "810009714743",
                "salePrice": 29.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6424/6424210_sd.jpg",
                "longDescription": "Equipped with a solar panel, the Renogy E.LUMEN 500 Multi-functional Flashlight harnesses the power of the sun to light your way in the dark. A built-in rechargeable battery is at the ready to power up your mobile devices at any time and an integrated seat belt cutter, glass shattering hammer, and magnetic attachment will have you prepared for vehicle emergencies and outdoor activities."
            },
            {
                "name": "Sun Joe - 24V iON+ Cordless 1500-Max LED Flashlight/Spotlight/Flood w/Battery/Charger - Green",
                "upc": "842470124745",
                "salePrice": 99.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6479/6479823_sd.jpg",
                "longDescription": "24V iON+ Cordless 1500-Max LED Flashlight/Spotlight/Flood w/Battery/Charger"
            },
            {
                "name": "DieHard - 1700-Lumen Flashlight",
                "upc": "035355461237",
                "salePrice": 27.99,
                "image": "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6321/6321404_sd.jpg",
                "longDescription": "Brighten your yard or work space with this DieHard flashlight. Simple twist action lets you focus the illumination from a flood to a precise beam that reaches up to 266m away. This DieHard flashlight runs for more than two hours on six AA batteries and is resistant to water and impacts to hold up in rugged conditions."
            }
        ]
    }
    """
        let data = jsonString.data(using: .utf8)!
        let searchResult = try! JSONDecoder().decode(SearchResult.self, from: data)
        return searchResult
    }()
}
