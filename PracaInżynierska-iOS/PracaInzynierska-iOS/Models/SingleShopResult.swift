//
//  SingleShopResult.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 17/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import Foundation

class SingleShopResult {
    
    var priceSum: Double
    var everyProductPrice: [Double]
    var shopName: String
    
    init(priceSum: Double, everyProductPrice: [Double], shopName: String) {
        self.priceSum = priceSum
        self.everyProductPrice = everyProductPrice
        self.shopName = shopName
    }
    
}
