//
//  PieChartExampleView.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI
import Charts

@available(macOS 14.0, *)
struct PieChartExampleView: View {
  let catData = PetData.catExample
  let dogData = PetData.dogExamples
  
  var catTotal: Double { catData.reduce(0) { $0 + $1.population } }
  var dogTotal: Double { dogData.reduce(0) { $0 + $1.population } }
  
  // Array of Tuple
  var data: [(type: String, amount: Double)] {
    [(type: "cat", amount: catTotal), (type: "dog", amount: dogTotal)]
  }
  
  var maxPet: String? {
    data.max { $0.amount < $1.amount }?.type
  }
  
    var body: some View {
      Chart(data, id: \.type) { pie in
        SectorMark(angle: .value("Type", pie.amount), innerRadius: .ratio(0.5), angularInset: 1.5)
          .cornerRadius(5).opacity(pie.type == maxPet ? 1 : 0.5)
      }
      .frame(height: 200)
    }
}

@available(macOS 14.0, *)
#Preview {
    PieChartExampleView()
}
