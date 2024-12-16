//
//  PetData.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import Foundation

struct PetData: Identifiable, Equatable {
  let year: Int
  
  // Population is in million
  let population: Double
  
  var id: Int { year }
  
  static var catExample: [PetData] {
    [PetData(year: 2000, population: 6.8),
     PetData(year: 2010, population: 8.2),
     PetData(year: 2015, population: 12.9),
     PetData(year: 2022, population: 15.2)]
  }
  
  static var dogExamples: [PetData] {
    [PetData(year: 2000, population: 5.0),
     PetData(year: 2010, population: 5.3),
     PetData(year: 2015, population: 7.9),
     PetData(year: 2022, population: 10.6)]
  }
}
