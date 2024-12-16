//
//  AreaChartExampleView.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI
import Charts

// MARK: - Area Chart
struct AreaChartExampleView: View {
  let catData = PetData.catExample
  let dogData = PetData.dogExamples
  
  var data: [(type: String, petData: [PetData])] {
    [(type: "cat", petData: catData), (type: "dog", petData: dogData)]
  }
  
    var body: some View {
      Chart(data, id: \.type) { dataSeries in
        ForEach(dataSeries.petData) { data in
          AreaMark(x: .value("Year", data.year), y: .value("Population", data.population))
        }
        .foregroundStyle(by: .value("Pet type", dataSeries.type))
      }
      .chartXScale(domain: 1998...2024)
      .aspectRatio(1, contentMode: .fit)
      .padding()
    }
}

#Preview {
  AreaChartExampleView().frame(maxHeight: .infinity, alignment: .top)
}

// MARK: - Gradient Area Chart
struct GradientAreaChartExampleView: View {
  let catData = PetData.catExample
  let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.4), Color.accentColor.opacity(0)]), startPoint: .top, endPoint: .bottom)
  
  var body: some View {
    Chart {
      ForEach(catData) { data in
        LineMark(x: .value("Year", data.year), y: .value("Population", data.population))
      }
      .interpolationMethod(.cardinal)
      .symbol(by: .value("Pet type", "cat"))
      
      ForEach(catData) { data in
        LineMark(x: .value("Year", data.year), y: .value("Population", data.population))
      }
      .interpolationMethod(.cardinal)
      .foregroundStyle(linearGradient)
    }
    .chartXScale(domain: 1998...2024)
    .chartLegend(.hidden)
    .chartXAxis {
      AxisMarks(values: [2000, 2010, 2015, 2022]) { value in
        AxisGridLine()
        AxisTick()
        if let year = value.as(Int.self) {
          AxisValueLabel(formatter(number: year), centered: false, anchor: .top)
        }
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .padding()
  }
  
  let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .none
    formatter.maximumFractionDigits = 0
    return formatter
  }()
  
  func formatter(number: Int) -> String {
    let result = NSNumber(value: number)
    return numberFormatter.string(from: result) ?? ""
  }
}

#Preview {
  GradientAreaChartExampleView().frame(maxHeight: .infinity, alignment: .top)
}
