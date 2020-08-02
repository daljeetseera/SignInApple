//
//  AppleSignInSwift.swift
//  AppleSignIn
//
//  Created by Daljeet Singh on 31/07/20.
//  Copyright © 2020 Daljeet Singh. All rights reserved.
//

import Foundation
import SwiftUI
import AuthenticationServices

final class AppleSignInSwift: UIViewRepresentable {
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: UIViewRepresentableContext<AppleSignInSwift>) {
    }
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        return button
    }
}
