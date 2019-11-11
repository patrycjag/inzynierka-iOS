//
//  ProductOffer.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 11/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import Foundation

class ProductOffer {
    
    var price: Double
    var shopName: String
    var shopImage: String
    var description: String
    var delivery: Double?
    
    init(price: Double, shopName: String, shopImage: String, description: String, delivery: Double?) {
        self.price = price
        self.shopName = shopName
        self.description = description
        self.delivery = delivery
        self.shopImage = shopImage
    }
}
