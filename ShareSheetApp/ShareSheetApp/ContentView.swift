//
//  ContentView.swift
//  ShareSheetApp
//
//  Created by MANAS VIJAYWARGIYA on 23/12/24.
//

import SwiftUI

struct ContentView: View {
  @State private var isSharePresented: Bool = false
  
  var body: some View {
    VStack {
      Button("Open Link in Browser") {
        isSharePresented = true
      }.buttonStyle(.borderedProminent)
    }
    .sheet(isPresented: $isSharePresented) {
      let urlString = "https://www.apple.com"
      if let url = URL(string: urlString) {
        ShareSheet(activityItems: [url])
      }
    }
  }
}

#Preview {
  ContentView()
}
