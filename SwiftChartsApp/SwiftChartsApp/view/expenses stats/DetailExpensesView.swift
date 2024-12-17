//
//  DetailExpensesView.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI

struct DetailExpensesView: View {
    
    @ObservedObject var expensesViewModel: ExpenseViewModel
    
    var body: some View {
        List {
            Group {
                Section {
                    ExpensesLineChartView(expensesViewModel: expensesViewModel)
                        .padding(.bottom)
                }
                
                Section {
                    Text("Detailed Breakdown of Your Expenses per Month")
                        .bold()
                        .padding(.top)
                    ExpensesDetailGridView(expensesViewModel: expensesViewModel)
                }
            }
            .listRowSeparator(.hidden)
            .listSectionSeparator(.visible)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
        }
        .listStyle(.plain)
      
    }
}

#Preview {
    DetailExpensesView(expensesViewModel: .preview)
}
