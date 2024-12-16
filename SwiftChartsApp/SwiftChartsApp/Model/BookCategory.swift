//
//  BookCategory.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import Foundation

enum BookCategory: String, Identifiable, CaseIterable {
  case fiction, biography, children, computerScience, fantasy, business
  
  var id: Self { self }
  
  var displayName: String {
    switch self {
      case .fiction: return "Fiction"
      case .biography: return "Biography"
      case .children: return "Children Books"
      case .computerScience: return "Computer Science"
      case .fantasy: return "Fantasy"
      case .business: return "Business"
    }
  }
}
