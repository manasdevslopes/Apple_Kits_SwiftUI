//
//  Team_SportsApp.swift
//  Team Sports
//
//  Created by Stewart Lynch on 2022-01-03.
//

import SwiftUI

@main
struct Team_SportsApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear {
          // This suppresses constraint warnings in console
          UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
          print("iOS Version : \(UIDevice.current.systemVersion)")
          print("Device Model : \(UIDevice.current.model)")
          print("Name of Device : \(UIDevice.current.name)")
          print("Model Name : \(UIDevice.current.modelName)")
          print("Display Name : \(Bundle.main.displayName)")
          print("App Version : \(Bundle.main.appVersion)")
          print("App Build : \(Bundle.main.appBuild)")
        }
    }
  }
}
