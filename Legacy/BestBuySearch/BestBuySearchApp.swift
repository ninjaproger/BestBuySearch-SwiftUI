//
//  BestBuySearchApp.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import SwiftUI

@main
struct BestBuySearchApp: App {
    let checkValidator: CheckValidator = .init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(checkValidator)
        }
    }
}
