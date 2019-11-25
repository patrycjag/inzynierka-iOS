//
//  ViewControllerPresentationExtension.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 13/10/2019.
//  Copyright © 2019 AGH. All rights reserved.
//
 import UIKit

extension UIViewController {
    
    //Purely visual benefits, since in every controller we would need those lines to get a new view controller
    func getViewController(withIdentifier id: String, fromStoryboard storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: id)
        return viewController
    }
    
}
