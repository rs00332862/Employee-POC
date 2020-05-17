//
//  NewEmployeeModel.swift
//  Employee POC
//
//  Created by Rohit on 5/17/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

// MARK: - CreateEmployeeModel
struct NewEmployeeResponseModel: Codable {
    let status: String
    let data: NewEmployee
}

struct NewEmployee: Codable {
    let name, salary, age: String
    let id: Int
}
