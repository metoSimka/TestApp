//
//  TextFieldValidator.swift
//  TestApp
//
//  Created by metoSimka on 21.09.2020.
//

import Foundation
import UIKit

class TextFieldValidator {
    static func emailValidate(textField: UITextField) {
        let email = textField.text?.trimmingCharacters(in: .whitespaces)
        if isValidEmail(checkString: email) {
            labelEmailStatus.text = nil
            delegate?.resetPassword(email: email)
            dismiss(animated: true, completion: nil)
        } else {
            labelEmailStatus.text = NSLocalizedString("The requested member could not be found.", comment: "The requested member could not be found")
        }
    }
    
    static func isValidEmail(checkString: String?) -> Bool {
        let emailRegex = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: checkString)
    }
    

    
    private func passwordValidate() {
        let textLenght = textFieldPassword.text?.count ?? 0
        let passwordIsValid = textLenght >= passwordValidLenght
        if passwordIsValid {
            hidePasswordError()
        } else {
            showPaswordError(errorMessage: "Password is too short")
        }
        loginButtonUpdate()
    }
}
