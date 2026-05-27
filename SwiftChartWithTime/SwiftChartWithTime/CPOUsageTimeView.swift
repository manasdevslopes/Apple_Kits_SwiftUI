//
// CPOUsageTimeView.swift
// SwiftChartWithTime
//
// Created by MANAS VIJAYWARGIYA on 27/05/26.
// ------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------
//

import Charts
import SwiftUI

struct CPOUsageTimeView: View {
  @StateObject var cpoUsageVM: CPOUsageViewModel = .preview
  
  @State private var scrollPosition: TimeInterval = TimeInterval()
  @State private var median: Bool = true
  @State private var plotsVisible: Bool = true
  
  let numberOfDisplayedHours = 12
  
  init() {
    guard let lastDate = cpoUsageVM.cpoUsageTimeData.last?.usageDate else { return }
    let calendar = Calendar.current
    let now = Date.now
    let startOfDay = calendar.startOfDay(for: lastDate)
    let currentHour = calendar.component(.hour, from: now)
    let targetHour = max(0, currentHour - numberOfDisplayedHours / 2) // center in 12-hour window
    let targetDate = startOfDay.addingTimeInterval(Double(targetHour) * 3600)
    
    self._scrollPosition = State(wrappedValue: targetDate.timeIntervalSinceReferenceDate)
  }
  
  var scrollPositionStart: Date {
    Date(timeIntervalSinceReferenceDate: scrollPosition)
  }
  
  var scrollPositionEnd: Date {
    scrollPositionStart.addingTimeInterval(3600 * Double(numberOfDisplayedHours))
  }
  
  var scrollPositionStartTimeString: String {
    scrollPositionStart.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute())
  }
  
  var scrollPositionEndTimeString: String {
    scrollPositionEnd.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute())
  }
  
  var scrollPositionDateString: String {
    scrollPositionStart.formatted(.dateTime.day().month().year())
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text("\(scrollPositionStartTimeString) - \(scrollPositionEndTimeString), \(scrollPositionDateString)")
        .font(.callout).foregroundStyle(.secondary)
      
      Chart(cpoUsageVM.cpoUsageTimeDataByHour) {
        BarMark(
          x: .value("Time", $0.id, unit: .hour),
          y: .value("Usage", $0.usage),
          width: .ratio(0.85)
        )
        .foregroundStyle(Color(.systemGreen))
        .opacity($0.usage == cpoUsageVM.maxHourlyUsage ? 1 : 0.4)
        
        if median {
          let medianVal = cpoUsageVM.medianHourlyUsage
          RuleMark(y: .value("Median", medianVal))
            .foregroundStyle(.gray)
            .lineStyle(StrokeStyle(lineWidth: 1))
            .annotation(position: .top, alignment: .leading) {
              Text("Median: \(String(format: "%.2f", medianVal))")
                .font(.body.bold()).foregroundStyle(.white).background(.teal)
            }
        }
      }
      .chartXAxis {
        AxisMarks(values: .stride(by: .hour, count: 2)) { _ in
          if plotsVisible {
            AxisGridLine()
            AxisTick()
          }
          AxisValueLabel(format: .dateTime.hour(.defaultDigits(amPM: .abbreviated)))
            .foregroundStyle(.gray).font(.caption2)
        }
      }
      .chartScrollableAxes(.horizontal)
      .chartYAxis(plotsVisible ? .visible : .hidden)
      // .chartXAxis(plotsVisible ? .visible : .hidden)
      .frame(height: 200)
      .chartXVisibleDomain(length: 3600 * numberOfDisplayedHours) // Show 12 hours
      // Snap to beginning of month when releasing scrolling
      .chartScrollTargetBehavior(
        .valueAligned(
          matching: .init(minute: 0), majorAlignment: .matching(.init(hour: 0))
        )
      )
      .chartScrollPosition(x: $scrollPosition)
      .aspectRatio(1, contentMode: .fill)
      
      Toggle(median ? "Hide Median" : "Show Median", isOn: $median)
      Toggle(plotsVisible ? "Hide Plots" : "Show Plots", isOn: $plotsVisible)
    }
  }
}

#Preview {
  CPOUsageTimeView().aspectRatio(1, contentMode: .fit).padding()
}
