//
//  VideoPlayer.swift
//  Pip Player
//
//  Created by MANAS VIJAYWARGIYA on 18/12/24.
//

import Foundation
import SwiftUI
import AVKit

// A SwiftUI view wrapper for an AVPlayerViewController
struct VideoPlayer: UIViewControllerRepresentable {
  // MARK: - Observed Object

  // ObservedObject that manages the underlying AVPlayer and its playback state
  @ObservedObject var playercontroller: PlayerController
  
  // MARK: - UIViewControllerRepresentable Protocol Methods
  // Create and configure the AVPlayerViewController
  func makeUIViewController(context: Context) -> AVPlayerViewController {
    return playercontroller.avPlayerViewController
  }
  
  // Update the AVPlayerViewController when SwiftUI view updates
  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    // Update the view controller if needed
    // (e.g., handle updates when the underlying AVPlayer changes)
  }
}
