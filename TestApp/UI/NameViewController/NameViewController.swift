//
//  NameViewController.swift
//  TestApp
//
//  Created by metoSimka on 21.09.2020.
//

import UIKit

class NameViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public var userAccount: UserAccount?
    
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    
    @IBOutlet weak var constraintButtonArrowBottom: NSLayoutConstraint!

    private let offsetNextButton: CGFloat = 11
    private let usernameValidLenght: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        textFieldFirstName.becomeFirstResponder()
    }

    @IBAction func next(_ sender: UIButton) {
        guard let newAccount = self.userAccount else {
            return
        }
        guard usernameValidate(textField: textFieldFirstName),
              usernameValidate(textField: textFieldLastName) else {
            return
        }
        let vc = EmailViewController()
        guard let firstName = textFieldFirstName.text else {
            return
        }
        guard let lastName = textFieldLastName.text else {
            return
        }
        newAccount.firstName = firstName
        newAccount.lastName = lastName
        vc.userAccount = newAccount
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func usernameValidate(textField: UITextField) -> Bool {
        let textLenght = textField.text?.count ?? 0
        let usernameIsValid = textLenght >= usernameValidLenght
        return usernameIsValid
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
