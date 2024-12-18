//
//  EventRow.swift
//  Events
//
//  Created by MANAS VIJAYWARGIYA on 18/12/24.
//

import EventKit
import SwiftUI

struct EventRow: View {
  var event: EKEvent
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(event.title).font(.headline)
      HStack {
        Text(event.startDate, style: .time)
        Text("-")
        Text(event.endDate, style: .time)
      }
      .font(.subheadline)
      .foregroundStyle(.gray)
    }
    .padding(.vertical, 5)
  }
}
