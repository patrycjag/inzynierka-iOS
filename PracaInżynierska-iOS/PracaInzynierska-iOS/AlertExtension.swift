//
//  AlertExtension.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 11/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit

extension UIViewController {
    
    typealias VoidFunc = () -> ()
    
    func showInfoAlert(alertTitle: String, description: String, firstTitle: String, firstAction: VoidFunc?) {
        let alert = UIAlertController(title: alertTitle, message: description, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: firstTitle, style: .cancel, handler: { _ in
            firstAction?()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
