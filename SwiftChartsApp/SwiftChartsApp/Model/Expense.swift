//
//  Expense.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import Foundation

struct Expense: Identifiable {
  let id: UUID = UUID()
  let title: String
  let category: ExpenseCategory
  let amount: Double
  let expenseDate: Date
  
  static var examples = [
  Expense(title: "Rent", category: .fixed, amount: 2000, expenseDate: Date(timeIntervalSince1970: -7_200_000)),
  Expense(title: "Salaries", category: .fixed, amount: 5000, expenseDate: Date(timeIntervalSince1970: -14_400_000)),
  Expense(title: "Utilities", category: .fixed, amount: 600, expenseDate: Date(timeIntervalSince1970: -21_600_000)),
  Expense(title: "Marketing", category: .variable, amount: 1000, expenseDate: Date(timeIntervalSince1970: -28_800_000)),
  Expense(title: "Inventory", category: .variable, amount: 3000, expenseDate: Date(timeIntervalSince1970: -36_000_000)),
  Expense(title: "Maintance", category: .fixed, amount: 500, expenseDate: Date(timeIntervalSince1970: -43_200_000)),
  Expense(title: "Equipment", category: .variable, amount: 1500, expenseDate: Date(timeIntervalSince1970: -50_400_000))
]
  
  static var yearExamples: [Expense] = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    var expenses = [Expense]()
    
    for month in 1...12 {
      for _ in 1...10 {
        let randomDay = Int.random(in: 1...28)
        let date = formatter.date(from: "2023/\(month)/\(randomDay)")!
        let category: ExpenseCategory = Bool.random() ? .fixed : .variable
        let title = category == .fixed ? "Rent" : "Supplies"
        let amount: Double = category == .fixed ? 2000 : Double.random(in: 100...500)
        expenses.append(Expense(title: title, category: category, amount: amount, expenseDate: date))
      }
    }
    return expenses
  }()
}

enum ExpenseCategory {
  case fixed, variable
  
  var displayName: String {
    switch self {
      case .fixed: return "Fixed"
      case .variable: return "Variable"
    }
  }
}
