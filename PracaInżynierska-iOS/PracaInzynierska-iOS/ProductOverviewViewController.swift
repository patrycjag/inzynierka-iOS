//
//  ProductOverviewViewController.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 13/10/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit

class ProductOverviewViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var shopOffersTableView: UITableView!
    
    private var isToastVisible = false
    var product: Product?
    var shopOffers = [ProductOffer]()
    var productImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shopOffersTableView.delegate = self
        self.shopOffersTableView.dataSource = self
        self.productNameLabel.text = self.product?.name
        self.productImageView.image = self.productImage ?? UIImage()
    }
    
    @IBAction func addToComparisonPressed(_ sender: UIButton) {
        guard let sProduct = self.product else {
            return
        }
        GlobalVariables.userBasket.append(sProduct)
        if !self.isToastVisible {
            self.view.makeToast("Dodano przedmiot do porównania.")
            self.isToastVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.isToastVisible = false
            }
        }
    }
}

extension ProductOverviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopOfferCell", for: indexPath) as! ShopOfferTableViewCell
        let shopOffer = self.shopOffers[indexPath.row]
        cell.descriptionLabel.text = shopOffer.description.replacingOccurrences(of: "\n", with: "")
        cell.priceLabel.text = "Cena od: \(shopOffer.price)zł"
        cell.shopImageView.sd_setImage(with: URL(string: shopOffer.shopImage.replacingOccurrences(of: "//", with: "https://")), completed: nil)
        cell.shopNameLabel.text = shopOffer.shopName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
