//
// Created for MyToDos
// by  Stewart Lynch on 2023-07-10
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on Twitter: https://twitter.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch

import SwiftUI
import OSLog

@main
struct MyToDosApp: App {
  // let logger = Logger(subsystem: "com.blacenova.MyToDos", category: "FileLocation")
  let logger = Logger.fileLocation
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(DataStore())
        .onAppear {
          print("ℹ️", URL.documentsDirectory.path())
          Debug.print(URL.documentsDirectory.path(), type: .info, extended: true)
          logger.info("\(URL.documentsDirectory.path())")
        }
    }
  }
}
