//
//  ResultTableViewCell.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 17/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var shopLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView! {
        didSet {
            cellBackgroundView.layer.borderColor = GlobalVariables.darkGray.cgColor
            cellBackgroundView.layer.borderWidth = 2
        }
    }
}
