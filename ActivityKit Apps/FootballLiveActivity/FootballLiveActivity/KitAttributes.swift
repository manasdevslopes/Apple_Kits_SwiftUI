//
// KitAttributes.swift
// FootballLiveActivity
//
// Created by MANAS VIJAYWARGIYA on 04/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
import ActivityKit
import SwiftUI

struct KitAttributes: ActivityAttributes {
  public typealias ScoreStatus = ContentState
  
  // Dynamic Data
  public struct ContentState: Codable, Hashable {
    var score: [String]
    var teams: [String]
    var time: String
    var scoreBy: [String: String]
  }
  
  // Static Data
  var name: String
}

