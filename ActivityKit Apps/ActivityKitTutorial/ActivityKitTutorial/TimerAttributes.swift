//
// TimerAttributes.swift
// ActivityKitTutorial
//
// Created by MANAS VIJAYWARGIYA on 04/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
import ActivityKit
import SwiftUI

struct TimerAttributes: ActivityAttributes {
  public typealias TimerStatus = ContentState
  
  // Dynamic Data
  public struct ContentState: Codable, Hashable {
    var endTime: Date
  }
  
  // Static Data
  var timerName: String
}
