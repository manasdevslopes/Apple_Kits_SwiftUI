//
//  ContentView.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject var salesViewModel: SalesViewModel = .preview
  @StateObject var expensesViewModel: ExpenseViewModel = .preview
  
  var body: some View {
    NavigationStack {
      
      List {
        Section {
          NavigationLink {
            DetailBookSalesView(salesViewModel: salesViewModel)
              .navigationBarTitleDisplayMode(.inline)
          } label: {
            SimpleBookSalesView(salesViewModel: salesViewModel)
          }
        }
        
        Section {
          NavigationLink {
            SalesByWeekdayView(salesViewModel: salesViewModel)
              .navigationBarTitleDisplayMode(.inline)
          } label: {
            SimpleSalesByWeekdayView(salesViewModel: salesViewModel)
          }
        }
        
        Section {
          NavigationLink {
            SalesPerBookCategoryView(salesViewModel: salesViewModel)
              .navigationBarTitleDisplayMode(.inline)
          } label: {
            
            SimpleSalesPerBookCategoryPieChartView(salesViewModel: salesViewModel)
          }
        }
        
        Section {
          NavigationLink {
            DetailExpensesView(expensesViewModel: expensesViewModel)
              .navigationBarTitleDisplayMode(.inline)
          } label: {
            SimpleExpensesLineChartView(expensesViewModel: expensesViewModel)
          }
        }
        
        
      }
      .navigationTitle("Your Book Store Stats")
    }
  }
}

#Preview {
  ContentView()
}
