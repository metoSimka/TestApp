//
//  EmailViewController.swift
//  TestApp
//
//  Created by metoSimka on 21.09.2020.
//

import UIKit

class EmailViewController: UIViewController {
    
    public var userAccount: UserAccount?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var constraintButtonArrowBottom: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        textFieldEmail.becomeFirstResponder()
    }

    @IBAction func next(_ sender: UIButton) {
        guard let textEmail = textFieldEmail.text else {
            return
        }
        guard let newAccount = self.userAccount else {
            return
        }
        let isValid = isValidEmail(checkString: textEmail)
        guard isValid else {
            return
        }
        
        let vc = CreatePasswordViewController()
        newAccount.email = textEmail
        vc.userAccount = newAccount
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func isValidEmail(checkString: String?) -> Bool {
        let emailRegex = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: checkString)
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
