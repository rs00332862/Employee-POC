//
//  Constant.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    static let baseURL = "http://dummy.restapiexample.com/api/"
    static let urlVersion = "v1/"
    static let getEmployeeListURL = baseURL+urlVersion+"employees"
    static let deleteEmployeeFromListURL = baseURL+urlVersion+"delete/"
    static let saveEmployeeDataURL = baseURL+urlVersion+"create"
    
    static let employeeCustomCellIdentifier = "EmployeeCell"
    

}
