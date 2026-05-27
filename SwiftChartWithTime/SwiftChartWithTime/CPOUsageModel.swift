//
// CPOUsageModel.swift
// SwiftChartWithTime
//
// Created by MANAS VIJAYWARGIYA on 27/05/26.
// ------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------
//
import Foundation

struct CPOUsageModel: Identifiable, Equatable {
  let id: UUID
  let cpoId: CPOId
  let usage: Int
  let usageDate: Date
  
  static var example = CPOUsageModel(id: UUID(), cpoId: CPOId.examples[0], usage: 5, usageDate: Date(timeIntervalSince1970: -7_200_000))
  
  static var examples = [
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[0], usage: 5, usageDate: Date(timeIntervalSince1970: -7_200_000)),
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[1], usage: 3, usageDate: Date(timeIntervalSince1970: -14_400_000)),
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[2], usage: 6, usageDate: Date(timeIntervalSince1970: -21_600_000)),
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[3], usage: 4, usageDate: Date(timeIntervalSince1970: -28_800_000)),
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[4], usage: 2, usageDate: Date(timeIntervalSince1970: -36_000_000)),
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[5], usage: 3, usageDate: Date(timeIntervalSince1970: -43_200_000)),
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[6], usage: 5, usageDate: Date(timeIntervalSince1970: -50_400_000)),
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[7], usage: 6, usageDate: Date(timeIntervalSince1970: -57_600_000)),
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[8], usage: 3, usageDate: Date(timeIntervalSince1970: -64_800_000)),
    CPOUsageModel(id: UUID(), cpoId: CPOId.examples[9], usage: 4, usageDate: Date(timeIntervalSince1970: -72_000_000))
  ]
  
  static func todayExample() -> [CPOUsageModel] {
    let calendar = Calendar.current
    let startOfDay = calendar.startOfDay(for: Date())
    let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
    
    let exampleCPOUsage: [CPOUsageModel] = (1...100).map { _ in
      let randomCPOId = CPOId.examples.randomElement()!
      let randomUsage = Int.random(in: 0...10)
      let randomDate = Date.random(in: startOfDay...endOfDay)
      
      return CPOUsageModel(id: UUID(), cpoId: randomCPOId, usage: randomUsage, usageDate: randomDate)
    }
    
    return exampleCPOUsage.sorted { $0.usageDate < $1.usageDate }
  }
}

extension Date {
  static func random(in range: ClosedRange<Date>) -> Date {
    let diff = range.upperBound.timeIntervalSinceReferenceDate - range.lowerBound.timeIntervalSinceReferenceDate
    let randomValue = diff * Double.random(in: 0...1) + range.lowerBound.timeIntervalSinceReferenceDate
    return Date(timeIntervalSinceReferenceDate: randomValue)
  }
}

struct CPOId: Identifiable, Equatable {
  let id: UUID
  let title: String
  
  static func == (lhs: CPOId, rhs: CPOId) -> Bool {
    lhs.id == rhs.id
  }
  
  static var example = CPOId(id: .init(), title: "A1")
  
  static var examples = [
    CPOId(id: .init(), title: "A1"),
    CPOId(id: .init(), title: "A2"),
    CPOId(id: .init(), title: "A3"),
    CPOId(id: .init(), title: "A4"),
    CPOId(id: .init(), title: "A5"),
    CPOId(id: .init(), title: "B1"),
    CPOId(id: .init(), title: "B2"),
    CPOId(id: .init(), title: "B3"),
    CPOId(id: .init(), title: "B4"),
    CPOId(id: .init(), title: "B5"),
    CPOId(id: .init(), title: "E1"),
    CPOId(id: .init(), title: "E2"),
    CPOId(id: .init(), title: "E3"),
    CPOId(id: .init(), title: "E4"),
    CPOId(id: .init(), title: "E5"),
    CPOId(id: .init(), title: "H1"),
    CPOId(id: .init(), title: "H2"),
    CPOId(id: .init(), title: "H3"),
    CPOId(id: .init(), title: "H4"),
    CPOId(id: .init(), title: "H5"),
  ]
}
