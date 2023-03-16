//
//  Models.swift
//  TechnicsShop
//
//  Created by Tazo Gigitashvili on 12.09.22.
//

import Foundation

class Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    var stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    var selectedQuantity:Int?
    
    init(id: Int, title: String, description: String, price: Int, stock: Int, brand: String, category: String, thumbnail: String) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.selectedQuantity = 0
    }
}

class ProductsData: Codable {
    let products: [Product]
    
    init(products: [Product]) {
        self.products = products
    }
}

