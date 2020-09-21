//
//  ViewController.swift
//  TestApp
//
//  Created by metoSimka on 21.09.2020.
//

import UIKit

class ViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isAuthorized = UserDefaultsService.default.isAuthorized()
        if isAuthorized {
            
        } else {
            openAuthorizationViewController()
        }
    }
    
    private func openAuthorizationViewController() {
        let vc = AuthorizationViewController(nibName: Constants.ControllerKeys.AuthorizationViewController, bundle: nil)
        let navVC = UINavigationController.init(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navVC.hidesBottomBarWhenPushed = true
        navVC.setNavigationBarHidden(true, animated: false)
        self.present(navVC, animated: false, completion: nil)
    }
}
