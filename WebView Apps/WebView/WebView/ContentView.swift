//
// ContentView.swift
// WebView
//
// Created by MANAS VIJAYWARGIYA on 03/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  @State private var webViewData: WebViewData?
  
  var body: some View {
    VStack {
      Button {
        let urlString = "https://www.apple.com"
        let title = "Apple"
        webViewData = WebViewData(title: title, url: urlString)
      } label: {
        Text("Open WebView").font(.system(size: 20, weight: .semibold)).underline().multilineTextAlignment(.leading).lineSpacing(4)
          .fixedSize(horizontal: false, vertical: true).frame(maxWidth: .infinity, alignment: .center)
      }
      .buttonStyle(.borderedProminent)
    }
    .padding()
    .fullScreenCover(item: $webViewData) { data in
      WebViewScreen(title: data.title, url: data.url)
    }
  }
}

#Preview {
  ContentView()
}
