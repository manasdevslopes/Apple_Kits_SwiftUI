//
//  Logger+Extension.swift
//  MyToDos
//
//  Created by MANAS VIJAYWARGIYA on 26/12/24.
//

import Foundation
import OSLog

extension Logger {
  static let subsystem = Bundle.main.bundleIdentifier!
  static let fileLocation = Logger(subsystem: subsystem, category: "FileLocation")
  static let dataStore = Logger(subsystem: subsystem, category: "DataStore")
  static let fileManager = Logger(subsystem: subsystem, category: "FileManager")
}
