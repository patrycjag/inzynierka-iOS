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
    
    @IBOutlet weak var ceneoSwitch: UISwitch!
    @IBOutlet weak var allegroSwitch: UISwitch!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        APIClient.shared.getDataFromCeneo()
    }
    
    //MARK: - Actions
    
    @IBAction func searchButtonPressed() {
        searchTextField.resignFirstResponder()
        let searchResultsVC = self.getViewController(withIdentifier: "searchResultsVC", fromStoryboard: "SearchResultsViewController")
        self.navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
    //MARK: - View setup
    
    private func setUpView() {
        searchTextField.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}

extension InitialSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchButtonPressed()
        return false
    }
    
}
