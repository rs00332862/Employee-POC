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

    func setEmployeeCellwith(isFilteringOn: Bool) {
        let employeeData = EmployeeViewModel().getEmployeeDataObject(forCellNumber: self.tag, andIsFilteringOn:isFilteringOn) as Employee
        employeeNameLabel.text = employeeData.employeeName
        employeeAgeLabel.text = "Age : \(employeeData.employeeAge)"
        employeeSalaryLabel.text = "Salary : \(numberFormaterWith(string: employeeData.employeeSalary))"
        employeeImageView.loadImageFromURL(employeeData.employeeProfileImageURL, placeHolder: UIImage (named: "NoImage"))
    }
    
    private func numberFormaterWith(string: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.groupingSeparator = ","
        let formattedNumber = numberFormatter.string(from: NSNumber(value:Int(string) ?? 0)) ?? ""
        return formattedNumber
    }
}

