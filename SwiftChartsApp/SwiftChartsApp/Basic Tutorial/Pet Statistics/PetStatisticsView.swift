//
//  PetStatisticsView.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI
import Charts

// MARK: - PetStatisticsView
struct PetStatisticsView: View {
  let catData = PetData.catExample
  let dogData = PetData.dogExamples
  
  var body: some View {
    Chart {
      ForEach(catData) { data in
        BarMark(x: .value("Year", data.year), y: .value("Population", data.population))
      }
      
      ForEach(dogData) { data in
        BarMark(x: .value("Year", data.year), y: .value("Population", data.population))
      }
      .foregroundStyle(.orange)
    }
    .chartXScale(domain: 1998...2024)
    .aspectRatio(1, contentMode: .fit).padding()
  }
}

#Preview {
  PetStatisticsView()
}

// MARK: - SecondPetStatisticsView
struct SecondPetStatisticsView: View {
  let catData = PetData.catExample
  let dogData = PetData.dogExamples
  
  // Array of Tuple
  var data: [(type: String, petData: [PetData])] {
    [(type: "cat", petData: catData), (type: "dog", petData: dogData)]
  }
  
  var body: some View {
    Chart(data, id: \.type) { dataSeries in
      ForEach(dataSeries.petData) { data in
        LineMark(x: .value("Year", data.year), y: .value("Population", data.population))
      }
      .foregroundStyle(by: .value("Pet type", dataSeries.type))
      .symbol(by: .value("Pet type", dataSeries.type))
    }
    .chartXScale(domain: 1998...2024)
    .aspectRatio(1, contentMode: .fit)
    .padding()
  }
}

#Preview("Second") {
  SecondPetStatisticsView()
}

// MARK: - ThirdPetStatisticsView
struct ThirdPetStatisticsView: View {
  struct PetDataSeries: Identifiable {
    let type : String
    let petData: [PetData]
    var id: String { type }
  }
  
  let catData = PetData.catExample
  let dogData = PetData.dogExamples
  
  // Array of Tuple
  var data: [PetDataSeries] {
    [PetDataSeries(type: "cat", petData: catData), PetDataSeries(type: "dog", petData: dogData)]
  }
  
  var body: some View {
    Chart(data) { dataSeries in
      ForEach(dataSeries.petData) { data in
        LineMark(x: .value("Year", data.year), y: .value("Population", data.population))
      }
      .foregroundStyle(by: .value("Pet type", dataSeries.type))
      .symbol(by: .value("Pet type", dataSeries.type))
    }
    .chartXScale(domain: 1998...2024)
    .aspectRatio(1, contentMode: .fit)
    .padding()
  }
}

#Preview("Third") {
  ThirdPetStatisticsView()
}
