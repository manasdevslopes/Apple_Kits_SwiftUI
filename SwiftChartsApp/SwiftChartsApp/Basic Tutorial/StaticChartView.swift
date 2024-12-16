//
//  StaticChartView.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI
import Charts

struct StaticChartView: View {
  @State private var averageIsShown: Bool = false
  
  var body: some View {
    VStack {
      Chart {
        BarMark(x: .value("Type", "bird"), y: .value("Population", 1)).opacity(0.5)
        BarMark(x: .value("Type", "dog"), y: .value("Population", 2)).opacity(0.5)
        BarMark(x: .value("Type", "cat"), y: .value("Population", 3))
        
        if averageIsShown {
          RuleMark(y: .value("Average", 1.5)).foregroundStyle(.gray)
            .annotation(position: .bottom, alignment: .bottomLeading) {
              Text("Average: 1.5")
            }
        }
        
      }
      .aspectRatio(1, contentMode: .fit)
      
      Toggle(averageIsShown ? "hide average" : "show average", isOn: $averageIsShown.animation())
    }
    .padding()
  }
}

#Preview {
  StaticChartView()
}
