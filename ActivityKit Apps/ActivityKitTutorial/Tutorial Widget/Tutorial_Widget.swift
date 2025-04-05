//
// Tutorial_Widget.swift
// Tutorial Widget
//
// Created by MANAS VIJAYWARGIYA on 04/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import ActivityKit
import WidgetKit
import SwiftUI

struct TimerActivityView: View {
  let context: ActivityViewContext<TimerAttributes>
  
  var body: some View {
    VStack {
      Text(context.attributes.timerName).font(.headline)
      Text(context.state.endTime, style: .timer)
    }
    .padding(.horizontal)
  }
}

struct Tutorial_Widget: Widget {
  
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: TimerAttributes.self) { context in
      TimerActivityView(context: context)
    } dynamicIsland: { _ in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) { }
        DynamicIslandExpandedRegion(.trailing) { }
        DynamicIslandExpandedRegion(.center) { }
        DynamicIslandExpandedRegion(.bottom) { }
      } compactLeading: { }
      compactTrailing: { }
      minimal: { }
    }
  }
}
