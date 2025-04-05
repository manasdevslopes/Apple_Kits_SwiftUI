//
// ContentView.swift
// FootballLiveActivity
//
// Created by MANAS VIJAYWARGIYA on 04/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
import ActivityKit
import SwiftUI

struct ContentView: View {
  @State private var activity: Activity<KitAttributes>? = nil
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
    let staticAttributes = KitAttributes(name: "Test")
    let dynamicAttributes = KitAttributes.ScoreStatus(score: ["1", "0"], teams: ["ARS", "MAN"], time: "40", scoreBy: ["Gabriel": "26"])
    
    activity = try? Activity<KitAttributes>.request(attributes: staticAttributes, content: .init(state: dynamicAttributes, staleDate: nil), pushType: nil)
  }
  
  func updateActivity() {
    Task {
      try await Task.sleep(for: .seconds(5))
      let activities = Activity<KitAttributes>.activities
      
      if let orderActivity = activities.first {
        let updateActivity = KitAttributes.ScoreStatus(score: ["1", "1"], teams: ["ARS", "MAC"], time: "50", scoreBy: ["Gabriel": "26", "Halland" : "46"])
        await activity?.update(ActivityContent(state: updateActivity, staleDate: nil))
      }
    }
  }
  
  func stopActivity() {
    let state = KitAttributes.ScoreStatus(score: [], teams: [], time: "", scoreBy: [:])
    
    Task {
      await activity?.end(ActivityContent(state: state, staleDate: nil), dismissalPolicy: .immediate)
    }
  }
}

#Preview {
    ContentView()
}
