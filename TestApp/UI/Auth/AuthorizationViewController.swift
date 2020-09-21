//
//  AuthorizationViewController.swift
//  TestApp
//
//  Created by metoSimka on 21.09.2020.
//

import UIKit

class AuthorizationViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logIn() {
        // TODO: - LogInViewController (not exist in figma yet)
    }
    
    @IBAction func createAccount() {
        let vc = NameViewController()
        let newAccount = UserAccount()
        vc.userAccount = newAccount
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
