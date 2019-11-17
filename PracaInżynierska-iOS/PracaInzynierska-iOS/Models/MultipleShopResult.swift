//
//  MultipleShopResult.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 17/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import Foundation

class MultipleShopResult {
    
    var prices: [Double]
    var shops: [String]
    var sumaricPrice: Double
    
    init(prices: [Double], shops: [String]) {
        self.prices = prices
        self.shops = shops
        self.sumaricPrice = prices.reduce(0, +)
    }
}
