//
// TimeTrackingAttributes.swift
// BasicTimeTracker
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import ActivityKit
import SwiftUI

struct TimeTrackingAttributes: ActivityAttributes {
  public typealias TimeTrackingStatus = ContentState
  
  // Dynamic Data
  public struct ContentState: Codable, Hashable {
    var startTime: Date
  }
  
  // Static Data
  var name: String
}

