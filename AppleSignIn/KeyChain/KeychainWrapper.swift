//
//  KeychainWrapper.swift
//  AppleSignIn
//
//  Created by Daljeet Singh on 01/08/20.
//  Copyright © 2020 Daljeet Singh. All rights reserved.
//

import Foundation
import KeychainSwift

struct keychainWrapper {
    
    static let shared = keychainWrapper()
    
    let keychain = KeychainSwift()
    func store(key: String, value: String) {
        
        keychain.set(value, forKey: key)
    }
    
    func getValue(key: String)-> String {
        return  keychain.get(key) ?? ""
    }
    
    func getAllKeys()-> [String] {
          return keychain.allKeys
       }
    
    func removeKey(key: String) {
        keychain.delete(key) // Remove single key
        keychain.clear()
    }
    
    func setValueWithResponse(key: String, value: String)-> Bool{
        if keychain.set(value, forKey: key) {
          return true
        }
          return false
    }
}
