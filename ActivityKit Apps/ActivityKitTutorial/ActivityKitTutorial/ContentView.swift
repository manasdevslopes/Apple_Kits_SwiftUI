//
// ContentView.swift
// ActivityKitTutorial
//
// Created by MANAS VIJAYWARGIYA on 04/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
import ActivityKit
import SwiftUI

struct ContentView: View {
  @State private var activity: Activity<TimerAttributes>? = nil
  
    var body: some View {
      VStack(spacing: 16) {
        Button("Start Activity") {
          startActivity()
        }
        Button("Update Activity") {
          updateActivity()
        }
        Button("Stop Activity") {
          stopActivity()
        }
      }
      .buttonStyle(.borderedProminent).controlSize(.large).padding()
    }
}

extension ContentView {
  func startActivity() {
    let attributes = TimerAttributes(timerName: "Dummy Timer")
    let state = TimerAttributes.TimerStatus(endTime: Date().addingTimeInterval(60 * 5))
    
    activity = try? Activity<TimerAttributes>.request(attributes: attributes, content: ActivityContent(state: state, staleDate: nil), pushType: nil)
  }
  
  func updateActivity() {
    let state = TimerAttributes.TimerStatus(endTime: Date().addingTimeInterval(60 * 10))
    
    Task {
      await activity?.update(ActivityContent(state: state, staleDate: nil))
    }
  }
  
  func stopActivity() {
    let state = TimerAttributes.TimerStatus(endTime: .now)
    
    Task {
      await activity?.end(ActivityContent(state: state, staleDate: nil), dismissalPolicy: .immediate)
    }
  }
}
#Preview {
    ContentView()
}
