//
// ContentView.swift
// BasicTimeTracker
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//

import ActivityKit
import SwiftUI

struct ContentView: View {
  @State private var activity: Activity<TimeTrackingAttributes>? = nil

  @State private var isTrackingTime: Bool = false
  @State private var startTime: Date? = nil
  
  var body: some View {
    NavigationStack {
      VStack {
        if let startTime {
          Text(startTime, style: .relative)
        }
        
        Button {
          isTrackingTime.toggle()
          
          if isTrackingTime {
            startTime = .now
            startTimeTracking()
          } else {
            stopTimeTracking()
            startTime = nil
          }
        } label: {
          Text(isTrackingTime ? "STOP" : "START")
            .fontWeight(.light).foregroundStyle(.white).frame(width: 200, height: 200)
            .background(Circle().fill(isTrackingTime ? .red : .green))
        }

      }
      .navigationTitle("Basic Time Tracker")
    }
  }
}

extension ContentView {
  func startTimeTracking() {
    let staticAttributes = TimeTrackingAttributes(name: "Timer")
    let dynamicAttributes = TimeTrackingAttributes.TimeTrackingStatus(startTime: .now)
    
    activity = try? Activity<TimeTrackingAttributes>.request(attributes: staticAttributes, content: .init(state: dynamicAttributes, staleDate: nil), pushType: nil)
  }
  
  func stopTimeTracking() {
    guard let startTime else { return }
    let state = TimeTrackingAttributes.ContentState(startTime: startTime)
    
    Task {
      await activity?.end(ActivityContent(state: state, staleDate: nil), dismissalPolicy: .immediate)
    }
  }
}
#Preview {
  ContentView()
}
