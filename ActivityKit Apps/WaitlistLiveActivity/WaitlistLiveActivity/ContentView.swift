//
// ContentView.swift
// WaitlistLiveActivity
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import ActivityKit
import SwiftUI

struct ContentView: View {
  @State private var waitlistName: String = ""
  @State private var queuePosition: Int = 0
  @State private var progress: Double = 0.0
  @State private var activity: Activity<WaitlistAttributes>? = nil
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Live Activity Demo").font(.title).padding(.top, 40)
      
      // Text Field for Waitlist Name
      TextField("Enter Waitlist Name", text: $waitlistName)
        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 20)
      
      // Text Field for Queue Position
      TextField("Enter Queue Position", value: $queuePosition, formatter: NumberFormatter())
        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 20).keyboardType(.numberPad)
      
      // Text Field for Progress
      TextField("Enter Progress (0.0 to 1.0)", value: $progress, formatter: numberFormatter)
        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 20).keyboardType(.decimalPad)
        .onChange(of: progress) { _, newValue in
          if newValue < 0.0 {
            progress = 0.0
          } else if newValue > 1.0 {
            progress = 1.0
          }
        }
      
      // Start Button
      Button(action: {
        LiveActivityManager.shared.startActivity(waitlistName: waitlistName, positionInQueue: queuePosition, progress: progress)
      }) {
        Text("Start Activity")
          .font(.headline).foregroundColor(.white)
          .padding().frame(maxWidth: .infinity).background(Color.blue).cornerRadius(10)
      }
      .padding(.horizontal, 20)
      
      // Update Button
      Button(action: {
        LiveActivityManager.shared.updateActivity(queuePosition: queuePosition, progress: progress)
      }) {
        Text("Update Activity")
          .font(.headline).foregroundColor(.white)
          .padding().frame(maxWidth: .infinity).background(Color.orange).cornerRadius(10)
      }
      .padding(.horizontal, 20)
      
      // End Button
      Button(action: {
        LiveActivityManager.shared.endActivity(positionInQueue: queuePosition, progress: progress)
      }) {
        Text("End Activity")
          .font(.headline).foregroundColor(.white)
          .padding().frame(maxWidth: .infinity).background(Color.red).cornerRadius(10)
      }
      .padding(.horizontal, 20)
      
      Spacer()
    }
    .padding()
  }
}

#Preview {
  ContentView()
}

extension ContentView {
  private var numberFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimum = 0
    formatter.maximum = 1
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }
}
