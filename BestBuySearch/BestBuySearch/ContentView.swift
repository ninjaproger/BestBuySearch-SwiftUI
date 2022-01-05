//
//  ContentView.swift
//  BestBuySearch
//
//  Created by Alexander Kharevich on 1/4/22.
//

import SwiftUI

struct ContentView: View {
    let searchDataSource: SearchDataSource = .init()
    var body: some View {
        SearchView(dataSource: searchDataSource)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
