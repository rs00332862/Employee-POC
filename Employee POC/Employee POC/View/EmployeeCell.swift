//
//  EmployeeCell.swift
//  Employee POC
//
//  Created by Rohit on 5/11/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeAgeLabel: UILabel!
    @IBOutlet weak var employeeSalaryLabel: UILabel!

    
    func setEmployeeCell() {
        employeeNameLabel.text = "Rohit Shivankar"
    }
}

