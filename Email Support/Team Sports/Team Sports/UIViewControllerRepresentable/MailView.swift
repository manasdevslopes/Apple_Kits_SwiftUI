//
//  MailView.swift
//  Team Sports
//
//  Created by MANAS VIJAYWARGIYA on 22/12/24.
//

import SwiftUI
import UIKit
import MessageUI

// Credit for this struct goes to https://swiftuirecipes.com/blog/send-mail-in-swiftui

typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

struct MailView: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentation
  @Binding var supportEmail: SupportEmail
  let callback: MailViewCallback
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
    let mvc = MFMailComposeViewController()
    mvc.mailComposeDelegate = context.coordinator
    mvc.setSubject(supportEmail.subject)
    mvc.setToRecipients([supportEmail.toAddress])
    mvc.setMessageBody(supportEmail.body, isHTML: false)
    mvc.addAttachmentData(supportEmail.data!, mimeType: "text/plain", fileName: "\(Bundle.main.displayName).json")
    mvc.accessibilityElementDidLoseFocus()
    return mvc
  }
  
  func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) { }
  
  class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    @Binding var presentation: PresentationMode
    @Binding var data: SupportEmail
    let callback: MailViewCallback
    
    init(presentation: Binding<PresentationMode>, data: Binding<SupportEmail>, callback: MailViewCallback) {
      _presentation = presentation
      _data = data
      self.callback = callback
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
      if let error {
        callback?(.failure(error))
      } else {
        callback?(.success(result))
      }
      $presentation.wrappedValue.dismiss()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(presentation: presentation, data: $supportEmail, callback: callback)
  }
  
  static var canSendMail: Bool {
    MFMailComposeViewController.canSendMail()
  }
}
