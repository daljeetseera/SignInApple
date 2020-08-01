//
//  EnvironmentWindowKey.swift
//  AppleSignIn
//
//  Created by Daljeet Singh on 31/07/20.
//  Copyright © 2020 Daljeet Singh. All rights reserved.
//

import Foundation
import SwiftUI

struct WindowKey: EnvironmentKey {
  struct Value {
    weak var value: UIWindow?
  }
  
  static let defaultValue: Value = .init(value: nil)
}

extension EnvironmentValues {
  var window: UIWindow? {
    get { return self[WindowKey.self].value }
    set { self[WindowKey.self] = .init(value: newValue) }
  }
}
