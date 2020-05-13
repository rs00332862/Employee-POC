//
//  EmployeeListViewController.swift
//  Employee POC
//
//  Created by Rohit on 5/11/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var employeeTableView: UITableView!
    var employeeViewModel = EmployeeViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performInitialSetup()
    }
    
    //MARK: - Class Private Functions
    
    /// perform initital set of activities as view controller is loaded
    ///
    /// Use this method to perform all intial activites as view controller is loaded like setting up UI and making service call
    private func performInitialSetup() {
        self.title = "Employee List"
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        getEmployeeDataFromViewModel()
        setUpSearchViewController()
    }
    
    /// Fetch employee data from view model class
    ///
    /// Use this method to get data from ViewModel class and manage its response status
    private func getEmployeeDataFromViewModel() {
        employeeViewModel.getEmployeeList {result in
            switch(result) {
            case .success:
                if(self.employeeViewModel.getCountOfEmployeeyData(IsFilteringOn: false) > 0) {
                    self.employeeTableView.reloadData()
                } else {
                    self.displayErrorMessageWith(messageString: NSLocalizedString("NoDataAvailable", comment: ""))
                }
            case .failure(let error):
                self.displayErrorMessageWith(messageString: error.localizedDescription)
            }
        }
    }
    
    func setUpSearchViewController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Employees"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
        
    /// Method to dsiplay error messages on veiwcontroller
    ///
    /// - Parameter messageString: String to be used while displaying error message
    func displayErrorMessageWith(messageString:String) {
        let alert = UIAlertController(title: NSLocalizedString("ErrorHeader", comment: ""), message: messageString , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OkButton", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension EmployeeListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeViewModel.getCountOfEmployeeyData(IsFilteringOn: isFiltering)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.employeeCustomCellIdentifier) as! EmployeeCell
        cell.tag = indexPath.row
        cell.setEmployeeCellwith(isFilteringOn: isFiltering)
        return cell
    }
}

extension EmployeeListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        employeeViewModel.filterEmployeeDataWith(string: searchBar.text!) {
            self.employeeTableView.reloadData()
        }
    }
}
