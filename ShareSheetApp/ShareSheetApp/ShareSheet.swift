//
//  ShareSheet.swift
//  ShareSheetApp
//
//  Created by MANAS VIJAYWARGIYA on 23/12/24.
//

import SwiftUI
import UIKit

class SafariActivity: UIActivity {
  private var url: URL?
  
  override var activityTitle: String? {
    "Open in Safari"
  }
  
  override var activityImage: UIImage? {
    UIImage(systemName: "safari")
  }
  
  override class var activityCategory: UIActivity.Category {
    .action
  }
  
  override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
    // Check if there's a URL to handle
    for item in activityItems {
      if let url = item as? URL, UIApplication.shared.canOpenURL(url) {
        self.url = url
        return true
      }
    }
    return false
  }
  
  override func perform() {
    guard let url = url else { return }
    UIApplication.shared.open(url)
    activityDidFinish(true)
  }
}

struct ShareSheet: UIViewControllerRepresentable {
  typealias UIViewControllerType = UIActivityViewController
  
  var activityItems: [Any]
  var applicationActivities: [UIActivity]? = [SafariActivity()]
  @Environment(\.dismiss) var dismiss
  
  func makeUIViewController(context: Context) -> UIActivityViewController {
    let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    //controller.modalPresentationStyle = .popover
    controller.completionWithItemsHandler = { _, _, _, _ in
      self.dismiss()
    }
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
}
