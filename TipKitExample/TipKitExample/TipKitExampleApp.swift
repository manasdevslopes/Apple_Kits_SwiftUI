//
//  TipKitExampleApp.swift
//  TipKitExample
//
//  Created by MANAS VIJAYWARGIYA on 21/12/24.
//
// Tip Kit in iOS 17 (Minimum Deployment)
//

import SwiftUI
import TipKit

@main
struct TipKitExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .task {
              // try? Tips.resetDatastore()
              // Tips.showAllTipsForTesting()
              // Tips.showTipsForTesting(<#T##tips: [any Tip.Type]##[any Tip.Type]#>)
              try? Tips.configure([
                .displayFrequency(.immediate), //daily, hourly, immediate, monthly, weekly per tip
                .datastoreLocation(.applicationDefault)
              ])
            }
        }
    }
}
