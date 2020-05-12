//
//  Employee.swift
//  Employee POC
//
//  Created by Rohit on 5/11/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

struct EmployeeDataMadel: Decodable{
    let employeeData: [Employee]
    
    enum CodingKeys: String, CodingKey {
        case employeeData = "data"
    }
}

struct Employee: Decodable {
    let employeeName: String
    let employeeAge: Int
    let employeeSalary: Double
    let employeeProfileImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case employeeName = "employee_name"
        case employeeAge = "employee_age"
        case employeeSalary = "employee_salary"
        case employeeProfileImageURL = "profile_image"
    }
}
