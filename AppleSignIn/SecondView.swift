//
//  SecondView.swift
//  AppleSignIn
//
//  Created by Daljeet Singh on 31/07/20.
//  Copyright © 2020 Daljeet Singh. All rights reserved.
//

import Foundation
import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center, spacing: 200) {
                Text("You are logged In").font(.largeTitle)
                Button(action: {
                    self.logout()
                    
                }) {
                    Text("Logout").fontWeight(.medium)
                        .font(.body)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 5))
                }
            }
        }
        .navigationBarTitle("Home", displayMode: .large)
        .navigationBarBackButtonHidden(true)
    }
    
    func logout() {
        // Handle your session token here
    self.presentationMode.wrappedValue.dismiss()
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
