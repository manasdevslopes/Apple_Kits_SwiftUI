//
// ShowWebView.swift
// WebView
//
// Created by MANAS VIJAYWARGIYA on 03/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI
import WebKit

struct ShowWebView: UIViewRepresentable {
  let url: URL
  
  func makeUIView(context: Context) -> WKWebView {
    WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    let request = URLRequest(url: url)
    uiView.load(request)
  }
}

#Preview {
  ShowWebView(url: URL(string: "https://www.apple.com")!)
}
