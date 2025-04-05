//
// InAppNotifExt.swift
// InAppCustomNotifDynamicIsland
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

extension UIApplication {
  func inAppNotification<Content: View>(adaptForDynamicIsland: Bool = false, timeOut: CGFloat = 5, swipeToClose: Bool = true, @ViewBuilder content: @escaping () -> Content) {
    // Fetching Active Window via WindowsScene
    if let activeWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.tag == 0320 }) {
      // Frame & SafeArea Values
      let frame = activeWindow.frame
      let safeArea = activeWindow.safeAreaInsets
      
      var tag: Int = 1009
      // Check for Dynamic Island
      let checkForDynamicIsland = adaptForDynamicIsland && safeArea.top >= 51
      
      if let previousTag = UserDefaults.standard.value(forKey: "in_app_notification_tag") as? Int {
        tag = previousTag + 1
      }
      UserDefaults.standard.setValue(tag, forKey: "in_app_notification_tag")
      
      // Changing Status into Black to Blend with Dynamic Island
      if checkForDynamicIsland {
        if let controller = activeWindow.rootViewController as? StatusBarBasedController {
          controller.statusBarStyle = .darkContent
          controller.setNeedsStatusBarAppearanceUpdate()
        }
      }
      
      // Creating UIView from SwiftUIView using UIHosting Configuration from iOS 16
      let config = UIHostingConfiguration {
        AnimatedNotificationView(safeArea: safeArea, tag: tag, adaptForDynamicIsland: checkForDynamicIsland, timeOut: timeOut, swipeToClose: swipeToClose, content: content())
          .frame(width: frame.width - (checkForDynamicIsland ? 20 : 30), height: 120, alignment: .top).contentShape(.rect)
      }
      
      // Creating UIView
      let view = config.makeContentView()
      view.tag = tag
      view.backgroundColor = .clear
      view.translatesAutoresizingMaskIntoConstraints = false
      
      if let rootView = activeWindow.rootViewController?.view {
        // Adding View to the Window
        rootView.addSubview(view)
        
        // Layout Constraints
        view.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: (-(frame.height - safeArea.top) / 2) + (checkForDynamicIsland ? 11 : safeArea.top)).isActive = true
      }
    }
  }
}

fileprivate struct AnimatedNotificationView<Content: View>: View {
  var safeArea: UIEdgeInsets
  var tag: Int
  var adaptForDynamicIsland: Bool
  var timeOut: CGFloat
  var swipeToClose: Bool
  var content: Content
  
  @State private var animateNotifications: Bool = false
  
  var body: some View {
    content
      .blur(radius: animateNotifications ? 0 : 10)
      .disabled(!animateNotifications)
      .mask {
        if adaptForDynamicIsland {
          //  Size based Capsule
          GeometryReader { geo in
            let size = geo.size
            let radius = size.height / 2
            
            RoundedRectangle(cornerRadius: radius, style: .continuous)
          }
        } else {
          Rectangle()
        }
      }
    // Scaling Animation only for Dynamic Island Notifications
      .scaleEffect(adaptForDynamicIsland ? (animateNotifications ? 1 : 0.01) : 1, anchor: .init(x: 0.5, y: 0.01))
    // Offset Animation for Non Dynamic Island Notifications
      .offset(y: offsetY)
      .gesture(
        DragGesture()
          .onEnded({ value in
            if -value.translation.height > 50 && swipeToClose {
              withAnimation(.smooth, completionCriteria: .logicallyComplete) {
                animateNotifications = false
              } completion: {
                removeNotificationViewFromWindow()
              }
            }
          })
      )
      .onAppear {
        Task {
          guard !animateNotifications else { return }
          withAnimation(.smooth) {
            animateNotifications = true
          }
          
          // Timeout for Notification
          try await Task.sleep(for: .seconds(timeOut < 1 ? 1 : timeOut))
          guard animateNotifications else { return }
          withAnimation(.smooth, completionCriteria: .logicallyComplete) {
            animateNotifications = false
          } completion: {
            removeNotificationViewFromWindow()
          }
        }
      }
  }
  
  var offsetY: CGFloat {
    if adaptForDynamicIsland {
      return 0
    }
    return animateNotifications ? 10 : -(safeArea.top + 130)
  }
  
  func removeNotificationViewFromWindow() {
    if let activeWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.tag == 0320 }) {
      if let view = activeWindow.viewWithTag(tag) {
        print("Removed View with tag: \(tag)")
        view.removeFromSuperview()
        
        // Resetting once all the notifications were removed
        if let controller = activeWindow.rootViewController as? StatusBarBasedController, controller.view.subviews.isEmpty {
          controller.statusBarStyle = .default
          controller.setNeedsStatusBarAppearanceUpdate()
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
