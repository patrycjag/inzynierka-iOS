//
//  InitialSearchViewController.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 12/10/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit

class InitialSearchViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var showBasketButton: UIButton!
    
    var activityView: ActivityIndicatorView?
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    //MARK: - Actions
    
    @IBAction func searchButtonPressed() {
        searchTextField.resignFirstResponder()
        guard let query = self.searchTextField.text, query != "" else {
            self.showInfoAlert(alertTitle: "Error", description: "Please enter a valid product name", firstTitle: "Ok", firstAction: nil)
            return
        }
        self.view.addSubview(activityView ?? UIView())
        APIClient.shared.getProducts(for: query.replacingOccurrences(of: " ", with: "+")) { result, error in
            self.activityView?.removeFromSuperview()
            guard let productArray = result, error == nil else {
                self.showInfoAlert(alertTitle: "Błąd", description: "Nie znaleźliśmy produktów spełniających warunki.", firstTitle: "Ok", firstAction: nil)
                return
            }
            
            let searchResultsVC = self.getViewController(withIdentifier: "searchResultsVC", fromStoryboard: "SearchResultsViewController") as! SearchResultsViewController
            searchResultsVC.productArray = productArray
            self.navigationController?.pushViewController(searchResultsVC, animated: true)
        }
    }
    
    @IBAction func showBasketPressed(_ sender: UIButton) {
        let controller = self.getViewController(withIdentifier: "basketVC", fromStoryboard: "BasketController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - View setup
    
    private func setUpView() {
        self.activityView = ActivityIndicatorView(frame: UIScreen.main.bounds)
        searchTextField.delegate = self
         self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}

//MARK: - Text Field

extension InitialSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchButtonPressed()
        return false
    }
    
}
