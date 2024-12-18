//
//  Pip_PlayerApp.swift
//  Pip Player
//
//  Created by MANAS VIJAYWARGIYA on 18/12/24.
//

import SwiftUI
import AVKit

// MARK: - Reference - https://medium.com/@afridi.khondakar/implementing-background-play-picture-in-picture-in-swiftui-building-a-video-streaming-app-with-141304b84728
/*
 Initial Steps as follows: -
 1. Add Capabilities in Background Modes — Audio, AirPlay and Picture in Picture.
 2. Increase deployment target to at least iOS-14.2, PiP mode is only supported on or after iOS-14.2.
 */

@main
struct Pip_PlayerApp: App {
  // Application delegate adaptor to setup the custom AppDelegate
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
    var body: some Scene {
        WindowGroup {
          NavigationStack {
              ContentView()
            }
        }
    }
}

// Custom AppDelegate to handle application lifecycle events
class AppDelegate: NSObject, UIApplicationDelegate {
  
  // This method is called when the application finishes launching
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let audioSession = AVAudioSession.sharedInstance()
    
    do {
      // Set the audio session category to playback
      try audioSession.setCategory(.playback)
      
      // Activate the audio session
      try audioSession.setActive(true, options: [])
    } catch {
      // Handle errors related to audio session setup
      print("Setting category to AVAudioSessionCategoryPlayback failed.")
    }
    return true
  }
}
