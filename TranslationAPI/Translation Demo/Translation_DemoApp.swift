//
// Translation_DemoApp.swift
// Translation Demo
//
// Created by MANAS VIJAYWARGIYA on 04/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
// MARK: - First tab is prior iOS 18. & Rest of the tabs are for iOS 18.
@main
struct Translation_DemoApp: App {
  @State private var translationService = TranslationService()
  
  var body: some Scene {
    WindowGroup {
      StartTab().environment(translationService)
    }
  }
}
