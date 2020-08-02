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
                Text("You are logged In").bold()
                Button(action: {
                    self.logout()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                
                    Text("Logout").bold()
                }
            }
        }
        .navigationBarTitle("Home", displayMode: .large)
         .navigationBarBackButtonHidden(true)
    }
 
    func logout() {
    
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}


