//
//  ContentView.swift
//  AppleSignIn
//
//  Created by Daljeet Singh on 31/07/20.
//  Copyright © 2020 Daljeet Singh. All rights reserved.
//

import UIKit
import SwiftUI
import AuthenticationServices

struct ContentView: View {
    
    @Environment(\.window) var window: UIWindow?
    @State var appleSignInDelegates: AppleSignInDelegate! = nil
    @State var showsAlert = false
    @State private var actionState: Int? = 0
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                AppleSignInSwift().frame(width: 330, height: 50).onTapGesture {
                    self.SignInTapped()
                } .alert(isPresented: $showsAlert) {
                    Alert(title: Text("Unable to login"), message: Text("You might have changed your apple id."), dismissButton: .default(Text("Okay")))
                }
                NavigationLink(destination: SecondView(), tag: 1, selection: $actionState) {
                    Text("")
                }
                    
                .onAppear {
                    self.checkAuthorizationState()
                    
                }
            }
        }
    }
    
    func checkAuthorizationState() {
        
        if #available(tvOS 13.0, *) {
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            
            let identifier = KeychainWrapper.shared.getValueFor(key: "user")
            
            if identifier.isEmpty {
                return
            }
            
            print(" identifier \(identifier)")
            appleIDProvider.getCredentialState(forUserID: identifier) { (credential, error) in
                
                switch credential {
                case .authorized:
                    print("authorized for sign in")
                    self.actionState = 1
                    break
                case .notFound:
                    print("Access Not found")
                    self.performExistingAccountSetupFlows()
                    break
                case .revoked:
                    print("Access revoked")
                    KeychainWrapper.shared.clearKeychain()
                    break
                case .transferred:
                    print("Access Transferred")
                    break
                default:
                    print("Apple sign in credential state unidentified")
                }
            }
        }
    }
    
    func SignInTapped() {
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        performSignIn(using: [request])
        
    }
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    private func performExistingAccountSetupFlows() {
        #if !targetEnvironment(simulator)
        // Note that this won't do anything in the simulator.  You need to
        // be on a real device or you'll just get a failure from the call.
        let requests = [
            ASAuthorizationAppleIDProvider().createRequest(),
            ASAuthorizationPasswordProvider().createRequest()
        ]
        
        performSignIn(using: requests)
        #endif
    }
    
    private func performSignIn(using requests: [ASAuthorizationRequest]) {
        appleSignInDelegates = AppleSignInDelegate(window: window) { success in
            if success {
                // update UI
                self.actionState = 1
                print("Update UI")
            } else {
                // show the user an error
                print("error in perform signin")
            }
        }
        
        let controller = ASAuthorizationController(authorizationRequests: requests)
        controller.delegate = appleSignInDelegates
        controller.presentationContextProvider = appleSignInDelegates
        
        controller.performRequests()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
