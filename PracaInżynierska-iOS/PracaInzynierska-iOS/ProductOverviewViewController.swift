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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shopOffersTableView.delegate = self
        self.shopOffersTableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopOfferCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
