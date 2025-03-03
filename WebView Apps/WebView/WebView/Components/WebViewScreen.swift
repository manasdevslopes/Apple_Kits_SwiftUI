//
// WebViewScreen.swift
// WebView
//
// Created by MANAS VIJAYWARGIYA on 03/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

// MARK: - The error arises because the .sheet(items: ) or .fullScreen(item: ) modifier requires the binding type (WebViewData in this case) to conform to the Identifiable protocol. Since String and URL do not conform to Identiafiable by default, we need to make them identifiable or handle this differently. Make title & url, Identifiable. Wrap title & url in a custom type that conforms to Identifiable.
struct WebViewData: Identifiable {
  let id = UUID()
  let title: String
  let url: String
}

struct WebViewScreen: View {
  @Environment(\.dismiss) var dismiss
  let title: String
  let url: String
  let onAppearCallback: (() -> ())?
  let onDismiss: (() -> ())?
  
  init(title: String, url: String, onAppearCallback: (() -> ())? = nil, onDismiss: (() -> ())? = nil) {
    self.title = title
    self.url = url
    self.onAppearCallback = onAppearCallback
    self.onDismiss = onDismiss
  }
  
  var body: some View {
    VStack {
      HStack {
        Text(title).font(.title).fontWeight(.medium)
      }
      .frame(maxWidth: .infinity, alignment: .center).frame(height: 45)
      .overlay(alignment: .leading) {
        Image(systemName: "xmark.app.fill").padding(.leading).font(.system(size: 30)).onTapGesture { self.dismiss() }
      }
      .foregroundStyle(.white).background(.teal)
      if let url = URL(string: url) {
        ShowWebView(url: url).ignoresSafeArea(.all, edges: .bottom)
      } else { Spacer() }
    }
    .onAppear {
      onAppearCallback?()
    }
    .onDisappear {
      onDismiss?()
    }
  }
}

#Preview {
  WebViewScreen(title: "Test", url: "https://www.apple.com")
}
