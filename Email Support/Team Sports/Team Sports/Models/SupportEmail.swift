//
//  SupportEmail.swift
//  Team Sports
//
//  Created by MANAS VIJAYWARGIYA on 22/12/24.
//

import SwiftUI

struct SupportEmail {
  let toAddress: String
  let subject: String
  let messageHeader: String
  var data: Data?
  
  var body: String {
    """
        Application Name: \(Bundle.main.displayName)
        iOS: \(UIDevice.current.systemVersion)
        Device Model: \(UIDevice.current.modelName)
        App Version: \(Bundle.main.appVersion)
        App Build: \(Bundle.main.appBuild)
        \(messageHeader)
        ---------------------------------------------
    """
  }
  
  func send(openURL: OpenURLAction) {
    let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")" // addingPercentEncoding is added becoz of spaces and special charaters.
    guard let url = URL(string: urlString) else { return }
    openURL(url) { accepted in
      if !accepted {
        print("""
              This device does not support email
              \(body)
              """
        )
      }
    }
  }
}
