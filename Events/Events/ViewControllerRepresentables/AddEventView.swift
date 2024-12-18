//
//  AddEventView.swift
//  Events
//
//  Created by MANAS VIJAYWARGIYA on 18/12/24.
//

import SwiftUI
import EventKitUI

struct AddEventView: UIViewControllerRepresentable {
  var eventStore: EKEventStore
  var onComplete: (EKEvent?) -> ()
  
  typealias UIViewControllerType = EKEventEditViewController
  
  func makeUIViewController(context: Context) -> EKEventEditViewController {
    let eventEditVC = EKEventEditViewController()
    eventEditVC.eventStore = eventStore
    eventEditVC.editViewDelegate = context.coordinator
    return eventEditVC
  }
  
  func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) { }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, EKEventEditViewDelegate {
    var parent: AddEventView
    
    init(_ parent: AddEventView) {
      self.parent = parent
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
      if action != .canceled, let event = controller.event {
        parent.onComplete(event)
      } else {
        parent.onComplete(nil)
      }
      controller.dismiss(animated: true)
    }
  }

}
