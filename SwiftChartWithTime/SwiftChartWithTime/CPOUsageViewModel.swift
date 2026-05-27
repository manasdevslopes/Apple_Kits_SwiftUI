//
// CPOUsageViewModel.swift
// SwiftChartWithTime
//
// Created by MANAS VIJAYWARGIYA on 27/05/26.
// ------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------
//

import SwiftUI
import Combine

class CPOUsageViewModel: ObservableObject {
  @Published var cpoUsageTimeData = [CPOUsageModel]()
  
  static var preview: CPOUsageViewModel {
    let vm = CPOUsageViewModel()
    vm.cpoUsageTimeData = CPOUsageModel.todayExample()
    return vm
  }
  
  var cpoUsageTimeDataByHour: [HourlyUsage] {
    let calendar = Calendar.current
    // Group all data points by which hour they fall in
    // items ar 2:15, 2:30, 2:45 all go into thr "2:00 AM" group
    let grouped = Dictionary(grouping: cpoUsageTimeData) { item in
      // dateInterval(of: .hour) return the start & end of the hour
      // for 2:37 PM -> returns interval starting at 2:00 PM
      // .start gives us just the start: 2:00 PM
      calendar.dateInterval(of: .hour, for: item.usageDate)!.start
    }
    
    // For each hour group, sum up all usage values into one HourlyUsage
    return grouped.map { (hour, items) in
      // reduce(0) starts at 0, then adds each item's usage
      // items ar 2:15 (usage=3), 2:30(usage=7), 2:45 (usage=5)
      // -> 0 + 3 + 7 + 5 = 15
      HourlyUsage(id: hour, usage: items.reduce(0) { $0 + $1.usage })
    }
    // Sort by hour (earliest first)
    .sorted { $0.id < $1.id }
  }
  
  var maxHourlyUsage: Int {
    cpoUsageTimeDataByHour.map { $0.usage }.max() ?? 0
  }
  
  var medianHourlyUsage: Double {
    // [2,8,3,10,5] becomes [2,3,5,8,10]
    // [2,8,3,5] becomes [2,3,5,8]
    let sorted = cpoUsageTimeDataByHour.map { $0.usage }.sorted()
    guard !sorted.isEmpty else { return 0 }
    let count = sorted.count
    if count % 2 == 0 {
      // count is even
      // [2,3,5,8]
      // sorted[4 / 2 - 1] = 3
      // sorted[4 / 2] = 5
      // 3 + 5 = 8
      // 8 / 2 = 4.0
      return Double(sorted[count / 2 - 1] + sorted[count / 2]) / 2.0
    } else {
      // Count is odd
      // [2,3,5,8,10] => 5
      return Double(sorted[count / 2])
    }
  }
  
}

struct HourlyUsage: Identifiable {
  let id: Date // start of the hour
  let usage: Int
}
