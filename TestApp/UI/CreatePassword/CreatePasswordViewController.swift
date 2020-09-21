//
//  CreatePasswordViewController.swift
//  TestApp
//
//  Created by metoSimka on 21.09.2020.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    
    public var userAccount: UserAccount?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var passwordValidLenght: Int = 6
    
    @IBOutlet weak var constraintButtonArrowBottom: NSLayoutConstraint!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        textFieldPassword.becomeFirstResponder()
    }

    @IBAction func next(_ sender: Any) {
        guard let newAccount = self.userAccount else {
            return
        }
        guard passwordValidate(textField: textFieldPassword) else {
            return
        }
        guard let password = self.textFieldPassword.text else {
            return
        }
        newAccount.password = password
        let vc = MapViewController(userAccount: newAccount)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func passwordValidate(textField: UITextField) -> Bool {
        let textLenght = textField.text?.count ?? 0
        let passordIsValid = textLenght >= passwordValidLenght
        return passordIsValid
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                let height = keyboardSize.height
                let newConstant = height
                constraintButtonArrowBottom.constant = newConstant
                NotificationCenter.default.removeObserver(self)
            }
        }
    }
}
