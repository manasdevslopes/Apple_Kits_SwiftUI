//
//  SalesPerBookCategoryListView.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI

struct SalesPerBookCategoryListView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        List {
            ForEach(salesViewModel.totalSalesPerCategory, id: \.category) { data in
                Section {
                    ForEach(salesViewModel.findBooks(for: data.category)) { book in
                        Text(book.title)
                            .badge(salesViewModel.sales(for: book))
                    }
                } header: {
                    HStack {
                        Text("\(data.category.rawValue)")
                        Text("\(data.sales)")
                    }
                }
            }
            
        }
    }
}

#Preview {
    SalesPerBookCategoryListView(salesViewModel: .preview)
}
