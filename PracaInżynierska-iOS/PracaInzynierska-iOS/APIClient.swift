//
//  APIClient.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 12/10/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    static var shared = APIClient()
    
    private let basePath: String = "http://ec2-35-180-69-117.eu-west-3.compute.amazonaws.com/api/v1/"
    
    func getProducts(for name: String, completion: @escaping(_ productArray: [Product]?, _ error: Error?) -> Void) {
        Alamofire.request(basePath + "product?productName=\(name)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            guard let responseJSON = response.result.value as? NSArray, response.result.isSuccess, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            var productArray = [Product]()
            
            for product in responseJSON {
                guard let productJSON = product as? NSDictionary, let offers = productJSON["offers"] as? NSDictionary, let brand = productJSON["brand"] as? NSDictionary else {
                    continue
                }
                
                let name = productJSON["name"] as? String ?? ""
                let image = productJSON["image"] as? String ?? ""
                let lowestPrice = offers["lowPrice"] as? Double ?? 0
                let brandName = brand["name"] as? String ?? ""
                let skapiecID = productJSON["sku"] as? Int
                
                let product = Product(brand: brandName, image: image, name: name, lowestPrice: lowestPrice, skapiecID: skapiecID ?? 0)
                productArray.append(product)
            }
            
            completion(productArray, nil)
        }
    }
    
    func getProductDetails(for id: String, completion: @escaping(_ productArray: [ProductOffer]?, _ error: Error?) -> Void) {
        Alamofire.request(basePath + "product/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            guard let responseJSON = response.result.value as? NSArray, let shopOffers = responseJSON[0] as? NSArray, response.result.isSuccess, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            var offerArray = [ProductOffer]()
            
            for product in shopOffers {
                guard let productJSON = product as? NSDictionary else {
                    continue
                }
                
                let price = productJSON["price"] as? Double ?? 0
                let shopImage = productJSON["imgUrl"] as? String ?? ""
                let shopName = productJSON["shopName"] as? String ?? ""
                let delivery = productJSON["delivery"] as? Double
                let description = productJSON["description"] as? String ?? ""
                let offer = ProductOffer(price: price, shopName: shopName, shopImage: shopImage, description: description, delivery: delivery)
                offerArray.append(offer)
            }
            
            completion(offerArray, nil)
        }
    }
}
