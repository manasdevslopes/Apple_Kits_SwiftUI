//
// InAppCustomNotifDynamicIslandApp.swift
// InAppCustomNotifDynamicIsland
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

@main
struct InAppCustomNotifDynamicIslandApp: App {
  @State private var overlayWindow: PassThroughWindow?
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear {
          if overlayWindow == nil {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
              let overlayWindow = PassThroughWindow(windowScene: windowScene)
              overlayWindow.backgroundColor = .clear
              overlayWindow.tag = 0320
              let controller = StatusBarBasedController()
              controller.view.backgroundColor = .clear
              overlayWindow.rootViewController = controller
              overlayWindow.isHidden = false
              overlayWindow.isUserInteractionEnabled = true
              self.overlayWindow = overlayWindow
              print("OverlayWindow Created")
            }
          }
        }
    }
  }
}

fileprivate class PassThroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard let view = super.hitTest(point, with: event) else { return nil }
    return rootViewController?.view == view ? nil : view
  }
}

class StatusBarBasedController: UIViewController {
  var statusBarStyle: UIStatusBarStyle = .default
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return statusBarStyle
  }
}
