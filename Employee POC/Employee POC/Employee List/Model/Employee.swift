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
    let webServiceResponse : String
    
    enum CodingKeys: String, CodingKey {
        case employeeData = "data"
        case webServiceResponse = "status"
    }
}

struct Employee: Decodable {
    let employeeName: String
    let employeeAge: String
    let employeeSalary: String
    let employeeProfileImageURL: String
    let employeeID: String
    
    enum CodingKeys: String, CodingKey {
        case employeeName = "employee_name"
        case employeeAge = "employee_age"
        case employeeSalary = "employee_salary"
        case employeeProfileImageURL = "profile_image"
        case employeeID = "id"
    }
}


struct deleteServiceModel: Decodable{
    let responseMessage: String
    let webServiceResponseStatus : String
    
    enum CodingKeys: String, CodingKey {
        case responseMessage = "message"
        case webServiceResponseStatus = "status"
    }
}
