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

    //MARK: - Outlets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK: - Variables
    
    var delegate: SearchResultCellDelegate?
    
    //MARK: - Actions
    
    @IBAction func addToBasketWasPressed(_ sender: UIButton) {
        self.delegate?.addToBasketWasPressed(onRow: productImageView.tag)
    }
    
}
