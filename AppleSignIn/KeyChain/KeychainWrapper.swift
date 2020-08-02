//
//  KeychainWrapper.swift
//  AppleSignIn
//
//  Created by Daljeet Singh on 01/08/20.
//  Copyright © 2020 Daljeet Singh. All rights reserved.
//

import Foundation
import KeychainSwift

struct KeychainWrapper {

    static let shared = KeychainWrapper()
    
    let keychain = KeychainSwift()
    func store(key: String, value: String) {
        keychain.set(value, forKey: key)
    }
    
    func getValueFor(key: String) -> String {
        return keychain.get(key) ?? ""
    }
    
    func getAllKeys() -> [String] {
        return keychain.allKeys
    }
    
    func remove(key: String) {
        keychain.delete(key) // Remove single key
    }
    
    func clearKeychain() {
        keychain.clear()
    }
    
    @discardableResult
    func set(key: String, value: String) -> Bool {
        if keychain.set(value, forKey: key) {
            return true
        }
        return false
    }
}
