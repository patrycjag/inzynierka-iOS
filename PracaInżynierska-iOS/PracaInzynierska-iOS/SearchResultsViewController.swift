//
//  SearchResultsViewController.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 13/10/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit
import Toast_Swift
import SDWebImage

class SearchResultsViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    //MARK: - Variables
    
    private var isToastVisible = false
    var productArray = [Product]()
    var activityView: ActivityIndicatorView?
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    //MARK: - View setup
    
    private func setUpView() {
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchTextField.delegate = self
        
        self.activityView = ActivityIndicatorView(frame: UIScreen.main.bounds)
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "basket")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.basketPressed))
        rightBarButtonItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    //MARK: - Actions
    
    @objc func basketPressed() {
        let controller = self.getViewController(withIdentifier: "basketVC", fromStoryboard: "BasketController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func searchButtonPressed() {
        searchTextField.resignFirstResponder()
        guard let query = self.searchTextField.text else {
            self.showInfoAlert(alertTitle: "Error", description: "Please enter a valid product name", firstTitle: "Ok", firstAction: nil)
            return
        }
        self.view.addSubview(activityView ?? UIView())
        APIClient.shared.getProducts(for: query.replacingOccurrences(of: " ", with: "+")) { result, error in
            self.activityView?.removeFromSuperview()
            guard let productResult = result, error == nil else {
                self.showInfoAlert(alertTitle: "Error", description: error!.localizedDescription, firstTitle: "Ok", firstAction: nil)
                return
            }
            
            self.productArray = productResult
            self.searchResultsTableView.reloadSections(IndexSet(integer: 0), with: .bottom)
        }
    }
}

//MARK: - Text field

extension SearchResultsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.resignFirstResponder()
        return false
    }
    
}

//MARK: - Table view

extension SearchResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.addSubview(activityView ?? UIView())
        APIClient.shared.getProductDetails(for: "\( productArray[indexPath.row].skapiecID)") { (response, error) in
            self.activityView?.removeFromSuperview()
            guard let offers = response, error == nil else {
                let description = error == nil ? "No available offers" : error!.localizedDescription
                self.showInfoAlert(alertTitle: "Error", description: description , firstTitle: "Ok", firstAction: nil)
                return
            }
            let cell = tableView.cellForRow(at: indexPath) as! SearchResultTableViewCell
            
            let controller = self.getViewController(withIdentifier: "productOverviewVC", fromStoryboard: "ProductOverviewViewController") as! ProductOverviewViewController
            controller.product = self.productArray[indexPath.row]
            controller.shopOffers = offers
            controller.productImage = cell.productImageView.image
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultTableViewCell
        let product = self.productArray[indexPath.row]
        cell.productImageView.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(), options: .continueInBackground, completed: nil)
        cell.productNameLabel.text = product.name
        cell.priceLabel.text = "Cena od: \n\(Int(product.lowestPrice))zł"
        cell.delegate = self
        cell.productImageView.tag = indexPath.row
        return cell
    }
    
}

//MARK: - Add to basket

extension SearchResultsViewController: SearchResultCellDelegate {
    
    func addToBasketWasPressed(onRow row: Int) {
        GlobalVariables.userBasket.append(self.productArray[row])
        if !self.isToastVisible {
            self.view.makeToast("Dodano przedmiot do porównania.")
            self.isToastVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isToastVisible = false
            }
        }
    }

}
