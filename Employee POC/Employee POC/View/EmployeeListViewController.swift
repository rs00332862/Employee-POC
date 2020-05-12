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
    var employeeList: [Employee] = []
    
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
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
    }

}

extension EmployeeListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell") as! EmployeeCell
        cell.setEmployeeCell()
        return cell
    }
}
