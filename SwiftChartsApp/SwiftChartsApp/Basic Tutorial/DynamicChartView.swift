//
//  DynamicChartView.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI
import Charts

struct ChartData: Identifiable, Equatable {
  let type: String
  let count: Int
  
  var id: String { type }
}

struct DynamicChartView: View {
  let data = [ChartData(type: "bird", count: 1), ChartData(type: "dog", count: 2), ChartData(type: "cat", count: 3)]
  
  var maxCount: ChartData? {
    data.max { $0.count < $1.count }
  }
  
  var body: some View {
      Chart {
        ForEach(data) {dataPoint in
          BarMark(x: .value("Type", dataPoint.type), y: .value("Population", dataPoint.count))
            .opacity(maxCount == dataPoint ? 1 : 0.5)
            .foregroundStyle(maxCount == dataPoint ? Color.accentColor : Color.gray)
        }
        
        RuleMark(y: .value("Average", 1.5)).foregroundStyle(.gray)
          .annotation(position: .bottom, alignment: .bottomLeading) {
            Text("Average: 1.5")
          }
      }
      .aspectRatio(1, contentMode: .fit)
  }
}

#Preview {
  DynamicChartView()
}
