//
// TimeTrackingWidget.swift
// TimeTrackingWidget
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import SwiftUI
import ActivityKit
import WidgetKit

struct TimeTrackingWidgetView: View {
  let context: ActivityViewContext<TimeTrackingAttributes>
  
  var body: some View {
    VStack {
      Text(context.state.startTime, style: .relative)
    }
  }
}

struct TimeTrackingWidget: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: TimeTrackingAttributes.self) { context in
      // Lock Screen/banner UI goes here
      TimeTrackingWidgetView(context: context)
    } dynamicIsland: { context in
      DynamicIsland {
        // Expanded UI goes here. Compose the expanded UI through various regions, like leading/trailing/center/bottom
        DynamicIslandExpandedRegion(.leading) {
          Text("MAIN L")
        }
        DynamicIslandExpandedRegion(.trailing) {
          Text("MAIN T")
        }
        DynamicIslandExpandedRegion(.bottom) {
          Text("MAIN B")
        }
        DynamicIslandExpandedRegion(.center) {
          Text("MAIN C")
        }
      } compactLeading: {
        Text("CL")
      } compactTrailing: {
        Text("CT")
      } minimal: {
        Text("M")
      }
      .widgetURL(URL(string: "https://www.apple.com"))
      .keylineTint(.red)
    }
  }
}
