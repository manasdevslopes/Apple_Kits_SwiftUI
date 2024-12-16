//
//  PointChartExampleView.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI
import Charts

struct PointChartExampleView: View {
  let catData = PetData.catExample
  let dogData = PetData.dogExamples
  
  var data: [(type: String, petData: [PetData])] {
    [(type: "cat", petData: catData), (type: "dog", petData: dogData)]
  }
  
    var body: some View {
      Chart(data, id: \.type) { point in
        ForEach(point.petData) { data in
          PointMark(x: .value("Year", data.year), y: .value("Population", data.population))
        }
        .foregroundStyle(by: .value("Pet type", point.type))
        .symbol(by: .value("Pet type", point.type))
      }
      .chartXScale(domain: 1998...2024)
      .aspectRatio(1, contentMode: .fit).padding()
    }
}

#Preview {
    PointChartExampleView()
}
