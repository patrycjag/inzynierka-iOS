//
//  Product.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 11/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import Foundation

class Product {
    
    var brand: String
    var image: String
    var name: String
    var lowestPrice: Double
    var skapiecID: Int
    
    init(brand: String, image: String, name: String, lowestPrice: Double, skapiecID: Int) {
        self.brand = brand
        self.image = image
        self.name = name
        self.lowestPrice = lowestPrice
        self.skapiecID = skapiecID
    }
    
}
