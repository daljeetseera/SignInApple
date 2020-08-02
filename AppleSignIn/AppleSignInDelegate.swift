//
//  AppleSignInDelegate.swift
//  AppleSignIn
//
//  Created by Daljeet Singh on 31/07/20.
//  Copyright © 2020 Daljeet Singh. All rights reserved.
//

import Foundation
import AuthenticationServices
import Contacts

final class AppleSignInDelegate: NSObject {
    
    private let signInSucceeded: (Bool) -> Void
    private weak var window: UIWindow!
    
    init(window: UIWindow?, onSignedIn: @escaping (Bool) -> Void) {
        self.window = window
        self.signInSucceeded = onSignedIn
    }
}

extension AppleSignInDelegate: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let cred as ASAuthorizationAppleIDCredential:
            if cred.email != nil, cred.fullName != nil {
                registration(credentials: cred)
            } else {
                signInWithExistingAccount(credential: cred)
            }
            
        default:
            break
        }
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        // You *should* have a fully registered account here.  If you get back an error from your server
        // that the account doesn't exist, you can look in the keychain for the credentials and rerun setup
        
        // if (WebAPI.Login(credential.user, credential.identityToken, credential.authorizationCode)) {
        //   ...
        // }
        self.signInSucceeded(true)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error \(error.localizedDescription)")
    }
    
    func registration(credentials: ASAuthorizationAppleIDCredential) {
        
        let emailSuccess = KeychainWrapper.shared.set(key: "email", value: credentials.email!)
        let userSuccess = KeychainWrapper.shared.set(key: "user", value: credentials.user)
        let name = (credentials.fullName?.givenName ?? "") + (credentials.fullName?.familyName ?? "")
        KeychainWrapper.shared.set(key: "name", value: name)
        
        if emailSuccess, userSuccess {
            print("Sign In Successfully")
            signInSucceeded(emailSuccess)
        }
    }
}

extension AppleSignInDelegate: ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.window
  }
}
