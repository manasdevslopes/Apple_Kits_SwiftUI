//
// Waitlist_Widget.swift
// Waitlist Widget
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import ActivityKit
import WidgetKit
import SwiftUI

struct WaitlistActivityView: View {
  let context: ActivityViewContext<WaitlistAttributes>
  
  var body: some View {
    VStack {
      HStack {
        Text(context.attributes.waitlistName).font(.system(size: 13))
          .fontWeight(.medium).lineLimit(1)
        Spacer()
        AppLogo(size: 24)
      }
      HStack {
        VStack(alignment: .leading) {
          QueuePostion(position: context.state.currentPositionInQueue)
          HorizontalProgressBar(level: context.state.progress).frame(height: 8)
        }
        Spacer()
        // QueueIllustration(position: context.state.position)
      }
    }.padding(16)
    
  }
}

struct HorizontalProgressBar: View {
  var level: Double
  
  var body: some View {
    GeometryReader { geometry in
      let frame = geometry.frame(in: .local)
      let boxWidth = frame.width * level
      
      RoundedRectangle(cornerRadius: 20).foregroundColor(Color("ContainerHigh"))
      
      RoundedRectangle(cornerRadius: 20).frame(width: boxWidth).foregroundColor(Color("PrimaryColor"))
    }
  }
}

struct QueuePostion: View {
  let position: Int
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .firstTextBaseline) {
        Text("\(position)").font(.system(size: 36, weight: .semibold)).lineSpacing(48)
        Text(" is your current").font(.system(size: 18, weight: .semibold)).lineSpacing(26)
      }
      Text("position in the queue").font(.system(size: 18, weight: .semibold))
    }
  }
}

struct QueueIllustration :View {
  let position: Int
  
  var imageName: String {
    if position < 5 {
      return "queue4"
    } else if position < 9 {
      return "queue3"
    } else if position < 25 {
      return "queue2"
    } else {
      return "queue1"
    }
  }
  
  var body: some View {
    Image(uiImage: UIImage(named: imageName)!).resizable().frame(width: 100, height: 100).scaledToFit()
  }
}

struct AppLogo :View {
  let size: CGFloat
  var body: some View {
    Image(systemName: "star.fill")
      .resizable().scaledToFit().frame(width: size, height: size).foregroundColor(Color("PrimaryColor"))
  }
}

struct MinimalProgressBar: View {
  let progress: Double
  let currentPositionInQueue: Int
  let size: CGFloat
  
  var body: some View {
    ProgressView(value: progress, total: 1) {
      Text("\(currentPositionInQueue)")
    }.frame(width: size, height: size)
      .progressViewStyle(.circular)
      .tint(Color("PrimaryColor"))
  }
}

struct Waitlist_Widget: Widget {
  
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: WaitlistAttributes.self) { context in
      WaitlistActivityView(context: context)
    } dynamicIsland: { context in
      DynamicIsland {
        expandedContent(
          waitlistName: context.attributes.waitlistName,
          contentState: context.state
        )
        // DynamicIslandExpandedRegion(.bottom) { }
      } compactLeading: {
        AppLogo(size: 24)
      }
      compactTrailing: {
        MinimalProgressBar(progress: context.state.progress, currentPositionInQueue: context.state.currentPositionInQueue, size: 24)
      }
      minimal: {
        MinimalProgressBar(progress: context.state.progress, currentPositionInQueue: context.state.currentPositionInQueue, size: 24)
      }
    }
  }
}

@DynamicIslandExpandedContentBuilder
private func expandedContent(waitlistName:String, contentState: WaitlistAttributes.ContentState) -> DynamicIslandExpandedContent<some View> {
  DynamicIslandExpandedRegion(.leading) {
    AppLogo(size: 48)
  }
  DynamicIslandExpandedRegion(.trailing) {
    MinimalProgressBar(progress: contentState.progress,
                       currentPositionInQueue: contentState.currentPositionInQueue, size: 48)
  }
  DynamicIslandExpandedRegion(.center) {
    Text("Your position in queue").font(.system(size: 12, weight: .medium))
  }
}
