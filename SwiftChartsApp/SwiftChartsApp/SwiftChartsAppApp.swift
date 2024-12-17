//
//  SwiftChartsAppApp.swift
//  SwiftChartsApp
//
//  Created by MANAS VIJAYWARGIYA on 16/12/24.
//

import SwiftUI

@main
struct SwiftChartsAppApp: App {
  var body: some Scene {
    WindowGroup {
#if os(iOS)
      ContentView()
#else
      MacContentView()
#endif
    }
  }
}
