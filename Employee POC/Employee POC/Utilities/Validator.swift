//
//  Validator.swift
//  Employee POC
//
//  Created by Rohit on 5/15/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
class Validator {
    public func validateName(name: String) ->Bool {
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        let nameRegex = "^[a-zA-Z0-9_ ]*$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
    public func validateAge(age: String) -> Bool {
        let phoneNumberRegex = "^[0-9]{0,3}+$"
        let trimmedString = age.trimmingCharacters(in: .whitespaces)
        let validateAge = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidAge = validateAge.evaluate(with: trimmedString)
        return isValidAge
    }
    public func validateSalary(salary: String) -> Bool {
        let phoneNumberRegex = "^[0-9]+(.[0-9]{0,2})?$"
        let trimmedString = salary.trimmingCharacters(in: .whitespaces)
        let validateSalary = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidSalary = validateSalary.evaluate(with: trimmedString)
        return isValidSalary
    }
}
