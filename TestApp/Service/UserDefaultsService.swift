//
//  UserDefaultsService.swift
//  TestApp
//
//  Created by metoSimka on 21.09.2020.
//

import Foundation

class UserDefaultsService {
    static let `default` = UserDefaultsService()
    
    public func isAuthorized() -> Bool {
        let isAuthorized = UserDefaults.standard.bool(forKey: Constants.Strings.isAuthorizedKey)
        return isAuthorized
    }
    
    public func setAuthorized(_ isAuthorized: Bool) {
        UserDefaults.standard.set(isAuthorized, forKey: Constants.Strings.isAuthorizedKey)
    }
}
