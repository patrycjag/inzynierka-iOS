//
//  ResultsViewController.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 17/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit
import SDWebImage

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var singleShopResult: SingleShopResult?
    var multipleShopResult: MultipleShopResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultsTableView.delegate = self
        self.resultsTableView.dataSource = self
        
        let totalPrice = self.singleShopResult == nil ? self.multipleShopResult?.sumaricPrice : self.singleShopResult?.everyProductPrice.reduce(0, +)
        self.totalPriceLabel.text = "Cena sumaryczna: \(totalPrice ?? 0)zł"
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.singleShopResult == nil ? self.multipleShopResult?.shops.count : self.singleShopResult?.everyProductPrice.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
        let product = GlobalVariables.userBasket[indexPath.row]
        cell.nameLabel.text = product.name
        let price = (self.singleShopResult == nil ?
            self.multipleShopResult?.prices[indexPath.row] :
            self.singleShopResult?.everyProductPrice[indexPath.row]) ?? 0
        cell.priceLabel.text = "Cena: \(price)zł"
        let imgUrl = URL(string: GlobalVariables.userBasket[indexPath.row].image)
        cell.productImageView?.sd_setImage(with: imgUrl, completed: nil)
        cell.shopLabel.text = "W sklepie: " + ((self.singleShopResult == nil ? self.multipleShopResult?.shops[indexPath.row] : self.singleShopResult?.shopName) ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
