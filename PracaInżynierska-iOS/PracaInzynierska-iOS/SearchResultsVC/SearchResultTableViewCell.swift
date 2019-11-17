//
//  SearchResultTableViewCell.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 13/10/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit

protocol SearchResultCellDelegate {
    func addToBasketWasPressed(onRow row: Int)
}

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var delegate: SearchResultCellDelegate?
    
    @IBAction func addToBasketWasPressed(_ sender: UIButton) {
        self.delegate?.addToBasketWasPressed(onRow: productImageView.tag)
    }
    
}
