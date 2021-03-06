//
//  EmployeeAddViewController.swift
//  Employee POC
//
//  Created by Rohit on 5/13/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class EmployeeAddViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var employeeNameErrorLabel: UILabel!
    @IBOutlet weak var employeeAgeTextField: UITextField!
    @IBOutlet weak var employeeAgeErrorLabel: UILabel!
    @IBOutlet weak var employeeSalaryTextField: UITextField!
    @IBOutlet weak var employeeSalaryErrorLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    let addEmployeeModel = EmployeeAddViewModel()
    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Add Employee"
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        addActivityIndicator()
    }
    
    //Calls this function when the tap is recognized on view to discmiss keyboard 
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //method to initiate save employee data service call
    @IBAction func saveEmployeeDetails(_ sender: Any) {
        if (validateTextFields()) {
            view.endEditing(true)
            self.activityView?.startAnimating()
            addEmployeeModel.createEmployee {result in
                self.activityView?.stopAnimating()
                switch(result) {
                case .success:
                    self.clearDataFromView()
                    self.displayErrorMessageWith(messageString: NSLocalizedString("EmployeeAddedSuccess", comment: ""))
                case .failure(let error):
                    self.displayErrorMessageWith(messageString: error.localizedDescription)
                }
            }
        }
    }
    
    //method to clear data on view controller once data is successfully added via web service
    func clearDataFromView() {
        employeeNameTextField.text = ""
        employeeAgeTextField.text = ""
        employeeSalaryTextField.text = ""
    }
    
    //method to validate data on addview controller
    func validateTextFields() -> Bool {
        let employeeName = employeeNameTextField.text
        if (employeeName == "") {
            displayErrorLabelFor(displayLabel: employeeNameErrorLabel, and: NSLocalizedString("NoEmployeeNameError", comment: ""))
            employeeNameTextField.becomeFirstResponder()
            return false
        }
        let validator = Validator()
        if (validator.validateName(name: employeeName!) == false) {
            displayErrorLabelFor(displayLabel: employeeNameErrorLabel, and: NSLocalizedString("EnterValidUserNameError", comment: ""))
            employeeNameTextField.becomeFirstResponder()
            return false
        }
        addEmployeeModel.employeeName = employeeName!;
        employeeNameErrorLabel.isHidden = true
        let employeeAge = employeeAgeTextField.text
        if (employeeAge == "") {
            displayErrorLabelFor(displayLabel: employeeAgeErrorLabel, and: NSLocalizedString("NoEmployeeAgeError", comment: ""))
            employeeAgeTextField.becomeFirstResponder()
            return false
        }
        if (validator.validateAge(age: employeeAge!) == false) {
            displayErrorLabelFor(displayLabel: employeeAgeErrorLabel, and: NSLocalizedString("EnterValidAgeError", comment: ""))
            employeeAgeTextField.becomeFirstResponder()
            return false
        }
        addEmployeeModel.employeeAge = employeeAge!;
        employeeAgeErrorLabel.isHidden = true
        let employeeSalary = employeeSalaryTextField.text
        if (employeeSalary == "") {
            displayErrorLabelFor(displayLabel: employeeSalaryErrorLabel, and: NSLocalizedString("NoEmployeeSalaryError", comment: ""))
            employeeSalaryTextField.becomeFirstResponder()
            return false
        }
        if (validator.validateSalary(salary: employeeSalary!) == false) {
            displayErrorLabelFor(displayLabel: employeeSalaryErrorLabel, and: NSLocalizedString("EnterValidSalaryError", comment: ""))
            employeeSalaryTextField.becomeFirstResponder()
            return false
        }
        addEmployeeModel.employeeSalary = employeeSalary!;
        employeeSalaryErrorLabel.isHidden = true
        return true
    }
    
    func displayErrorLabelFor(displayLabel: UILabel, and massage: String) {
        displayLabel.isHidden = false
        displayLabel.text = massage
    }
    

    
    /// Method to dsiplay error messages on veiwcontroller
    ///
    /// - Parameter messageString: String to be used while displaying error message
    func displayErrorMessageWith(messageString:String) {
        let alert = UIAlertController(title: NSLocalizedString("ErrorHeader", comment: ""), message: messageString , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OkButton", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    ///function to add activity indicator on view controller
    func addActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView?.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        activityView?.hidesWhenStopped = true
        view.addSubview(activityView!)
    }
    
    //MARK: - Textfield Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == employeeNameTextField {
            textField.resignFirstResponder()
            employeeAgeTextField.becomeFirstResponder()
        } else if textField == employeeAgeTextField {
            textField.resignFirstResponder()
            employeeSalaryTextField.becomeFirstResponder()
        } else if textField == employeeSalaryTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: - UIBUtton extension
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
