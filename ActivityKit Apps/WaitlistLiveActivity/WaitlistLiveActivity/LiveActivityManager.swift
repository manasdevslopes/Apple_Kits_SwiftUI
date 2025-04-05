//
// LiveActivityManager.swift
// WaitlistLiveActivity
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Foundation
import ActivityKit


class LiveActivityManager {
  static let shared = LiveActivityManager()
  private var activity: Activity<WaitlistAttributes>?
  
  private init() {}
  
  func startActivity(waitlistName: String, positionInQueue: Int, progress: Double) {
    print("waitlistName: \(waitlistName), positionInQueue: \(positionInQueue), progress: \(progress)")
    if ActivityAuthorizationInfo().areActivitiesEnabled {
      // Define the initial state and attributes
      let attributes = WaitlistAttributes(waitlistName: waitlistName, bookingId: "1234")
      let initialContentState = WaitlistAttributes.WaitlistStatus(
        currentPositionInQueue: positionInQueue,
        progress: progress
      )
      // Start the live activity
      do {
        let activity = try Activity<WaitlistAttributes>.request(
          attributes: attributes,
          content: .init(state: initialContentState, staleDate: nil),
          pushType: nil // No pushType since we're handling it in-app for now
        )
        self.activity = activity
        print("Live activity started: \(activity.id)")
      } catch {
        print("Failed to start live activity: \(error)")
      }
    }
  }
  
  func updateActivity(queuePosition: Int, progress: Double) {
    guard let activity = activity else { return }
    
    let updatedContentState = WaitlistAttributes.ContentState(currentPositionInQueue: queuePosition, progress: progress)
    
    Task {
      await activity.update(ActivityContent(state: updatedContentState, staleDate: nil))
      print("Live Activity updated with queue position: \(queuePosition) and progress: \(progress).")
    }
  }
  
  func endActivity(positionInQueue: Int, progress: Double) {
    guard let activity = activity else { return }
    
    let endContent = WaitlistAttributes.ContentState(currentPositionInQueue: 1, progress: 1.0)
    
    Task {
      await activity.end(ActivityContent(state: endContent, staleDate: nil), dismissalPolicy: .immediate)
      print("Live Activity ended.")
    }
  }
}

