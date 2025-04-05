//
// WaitlistAttributes.swift
// WaitlistLiveActivity
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import ActivityKit
import SwiftUI

struct WaitlistAttributes: ActivityAttributes {
  public typealias WaitlistStatus = ContentState
  
  // Dynamic Data
  public struct ContentState: Codable, Hashable {
    var currentPositionInQueue: Int
    var progress: Double
  }
  
  // Static Data
  var waitlistName: String
  var bookingId: String
}

