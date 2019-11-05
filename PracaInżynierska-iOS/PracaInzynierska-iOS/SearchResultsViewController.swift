//
//  SearchResultsViewController.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 13/10/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit
import Toast_Swift

class SearchResultsViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    private var isToastVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    private func setUpView() {
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchTextField.delegate = self
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "basket")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.basketPressed))
        rightBarButtonItem.tintColor = UIColor.systemYellow
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func basketPressed() {
        let controller = self.getViewController(withIdentifier: "basketVC", fromStoryboard: "BasketController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func searchButtonPressed() {
        
    }
}

extension SearchResultsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.resignFirstResponder()
        return false
    }
    
}

extension SearchResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.getViewController(withIdentifier: "productOverviewVC", fromStoryboard: "ProductOverviewViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultTableViewCell
        cell.delegate = self
        cell.productImageView.tag = indexPath.row
        return cell
    }
    
}

extension SearchResultsViewController: SearchResultCellDelegate {
    
    func addToBasketWasPressed(onRow row: Int) {
        
        //Add new item to basket TODO
//        GlobalVariables.userBasket.append("")
        print("ADDING FROM ROW: \(row)")
        if !self.isToastVisible {
            self.view.makeToast("Dodano przedmiot do porównania.")
            self.isToastVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.isToastVisible = false
            }
        }
    }

}
