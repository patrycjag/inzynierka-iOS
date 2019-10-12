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
    
    func fetchData(completion: @escaping(_ error: Error?) -> Void) {
        Alamofire.request("", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString { response in
            print(response)
        }
    }
    
}
