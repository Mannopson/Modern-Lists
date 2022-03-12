//
//  Model.swift
//  ListCollectionView
//
//  Created by AzizOfficial on 3/9/22.
//

import Foundation

struct Model: Hashable {
    let item: String
    let value: Int
    let products: [Types]
    private let id = UUID.init()
}

struct Types: Hashable {
    let productName: String
    private let productID = UUID.init()
}
