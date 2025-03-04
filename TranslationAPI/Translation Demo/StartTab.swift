//
// StartTab.swift
// Translation Demo
//
// Created by MANAS VIJAYWARGIYA on 04/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct StartTab: View {
  var body: some View {
    TabView {
      Tab("Basic", systemImage:  "1.circle.fill") {
        BasicTranslationView()
      }
      Tab("Flexible Translation", systemImage: "2.circle.fill") {
        FlexibleTranslationView()
      }
      Tab("Muiltiple Translations", systemImage: "3.circle.fill") {
        MultipleTranslationsView()
      }
      Tab("Scan and Translate", systemImage: "4.circle.fill") {
        ScanAndTranslateView()
      }
    }
  }
}

#Preview {
  StartTab()
}

