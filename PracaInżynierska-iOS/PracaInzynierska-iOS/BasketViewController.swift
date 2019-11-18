//
//  BasketViewController.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 05/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var singleShopSwitch: UISwitch!
    @IBOutlet weak var deliveryCostSwitch: UISwitch!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var productTableVIew: UITableView!
    @IBOutlet weak var emptyBasketLabel: UILabel!
    
    //MARK: - Variables
    
    var loader: ActivityIndicatorView?
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.productTableVIew.delegate = self
        self.productTableVIew.dataSource = self
        
        self.loader = ActivityIndicatorView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.productTableVIew.isHidden = GlobalVariables.userBasket.count == 0
    }
    
    //MARK: - Actions

    @IBAction func compareWasPressed(_ sender: UIButton) {
        guard GlobalVariables.userBasket.count > 0 else {
            self.showInfoAlert(alertTitle: "Koszyk pusty", description: "Dodaj produkty do porównania aby znaleźć najlepsze oferty", firstTitle: "Ok", firstAction: nil)
            return
        }
        
        self.view.addSubview(self.loader ?? UIView())
        calculateAndShowResults()
    }
    
    //MARK: - Supplementary
    
    private func calculateAndShowResults() {
        APIClient.shared.calculateBestDeals(withDelivery: self.deliveryCostSwitch.isOn, fromOneShop: self.singleShopSwitch.isOn) { (response, error) in
            self.loader?.removeFromSuperview()
            
            guard error == nil else {
                self.showInfoAlert(alertTitle: "Error", description: error!.localizedDescription, firstTitle: "Ok", firstAction: nil)
                return
            }
        
            let resultController = self.getViewController(withIdentifier: "resultsVC", fromStoryboard: "ResultViewController") as! ResultsViewController
            resultController.multipleShopResult = response.1
            resultController.singleShopResult = response.0
            self.navigationController?.pushViewController(resultController, animated: true)
        }
    }
}

//MARK: - Basket Delegate

extension BasketViewController: BasketDeleteDelegate {
    
    func productWasDeleted(atRow: Int) {
        GlobalVariables.userBasket.remove(at: atRow)
        self.productTableVIew.deleteRows(at: [IndexPath(row: atRow, section: 0)], with: .right)
        self.productTableVIew.reloadSections(IndexSet(arrayLiteral: 0), with: .top)
    }
}

//MARK: - Table View

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GlobalVariables.userBasket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! BasketProductTableViewCell
        let product = GlobalVariables.userBasket[indexPath.row]
        cell.productImageView.sd_setImage(with: URL(string: product.image), completed: nil)
        cell.priceLabel.text = "Cena od:\n\(product.lowestPrice)zł"
        cell.deleteButton.tag = indexPath.row
        cell.productName.text = product.name
        cell.delegate = self
        return cell
    }
    
}
