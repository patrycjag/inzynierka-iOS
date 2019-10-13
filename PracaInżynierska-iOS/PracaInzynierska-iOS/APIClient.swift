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
    
    let basePath: String = "http://ec2-35-180-69-117.eu-west-3.compute.amazonaws.com/api/v1/"
    
    func fetchData(completion: @escaping(_ error: Error?) -> Void) {
        Alamofire.request(basePath + "getAllProducts", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            print(response)
        }
    }
    
    func getDataFromCeneo() {
        Alamofire.request("https://partnerzyapi.ceneo.pl/PartnerService.svc/GetProducts", method: .get, parameters: ["searchtext":"iphone"], encoding: URLEncoding.default, headers: nil).responseString { response in
                  print(response)
              }

    }
    
}
