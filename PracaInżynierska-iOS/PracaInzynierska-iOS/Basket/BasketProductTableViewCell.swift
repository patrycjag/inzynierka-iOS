//
//  BasketProductTableViewCell.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 16/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit

protocol BasketDeleteDelegate {
    func productWasDeleted(atRow: Int)
}

class BasketProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate: BasketDeleteDelegate?
    
    @IBAction func deleteButtonWasPressed(_ sender: UIButton) {
        self.delegate?.productWasDeleted(atRow: sender.tag)
    }
    
}
