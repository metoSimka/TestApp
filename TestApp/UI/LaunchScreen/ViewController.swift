//
//  ViewController.swift
//  TestApp
//
//  Created by metoSimka on 21.09.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isAuthorized = UserDefaultsService.default.isAuthorized()
        if isAuthorized {
            
        } else {
            
        }
    }
}

