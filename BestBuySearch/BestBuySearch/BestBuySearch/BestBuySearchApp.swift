//
//  BestBuySearchApp.swift
//  BestBuySearch
//

import AppCore
import ComposableArchitecture
import SwiftUI

@main
struct BestBuySearchApp: App {
    let store = Store(initialState: AppCoreReducer.State()) {
        AppCoreReducer()
    }

    var body: some Scene {
        WindowGroup {
            AppCoreView(store: store)
        }
    }
}
