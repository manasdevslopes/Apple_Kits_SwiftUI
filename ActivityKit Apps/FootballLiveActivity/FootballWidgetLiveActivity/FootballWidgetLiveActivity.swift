//
// FootballWidgetLiveActivity.swift
// FootballWidgetLiveActivity
//
// Created by MANAS VIJAYWARGIYA on 04/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import SwiftUI
import ActivityKit
import WidgetKit

struct FootballActivityView: View {
  let context: ActivityViewContext<KitAttributes>
  
  var body: some View {
    VStack {
      Text("\(context.state.time) min")
      HStack {
        Text("\(context.state.teams[0]) : \(context.state.score[0])")
        Text("-")
        Text("\(context.state.score[1]) : \(context.state.teams[1])")
      }
      ForEach(context.state.scoreBy.sorted(by: <), id: \.key) { value, key in
        HStack {
          Text(key)
          Text("-")
          Text(value)
          Image(systemName: "soccerball")
        }
      }
    }
    .activityBackgroundTint(.cyan).activitySystemActionForegroundColor(.black)
  }
}

struct FootballWidgetLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: KitAttributes.self) { context in
      // Lock Screen/banner UI goes here
      FootballActivityView(context: context)
    } dynamicIsland: { context in
      DynamicIsland {
        // Expanded UI goes here. Compose the expanded UI through various regions, like leading/trailing/center/bottom
        DynamicIslandExpandedRegion(.leading) {
          Text(" \(context.state.teams[0]) : \(context.state.score[0]) ")
        }
        DynamicIslandExpandedRegion(.trailing) {
          Text(" \(context.state.score[1]) : \(context.state.teams[1]) ")
        }
        DynamicIslandExpandedRegion(.bottom) {
          ForEach(context.state.scoreBy.sorted(by: <), id: \.key) { value, key in
            HStack {
              Text(key)
              Text("-")
              Text(value)
              Image(systemName: "soccerball")
            }
          }
        }
        DynamicIslandExpandedRegion(.center) {
          Text(" \(context.state.time) min")
        }
      } compactLeading: {
        Text(" \(context.state.teams[0]) : \(context.state.score[0]) ")
      } compactTrailing: {
        Text(" \(context.state.score[1]) : \(context.state.teams[1]) ")
      } minimal: {
        Text(context.state.teams[0])
      }
      .widgetURL(URL(string: "https://www.apple.com"))
      .keylineTint(.red)
    }
  }
}
