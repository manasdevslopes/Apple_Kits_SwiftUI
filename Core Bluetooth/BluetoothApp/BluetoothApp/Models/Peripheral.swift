//
//  Peripheral.swift
//  BluetoothApp
//
//  Created by MANAS VIJAYWARGIYA on 23/12/24.
//

import Foundation

struct Peripheral: Identifiable {
  let id: UUID
  let name: String
  let rssi: Int // Declare a constant property 'rssi' of type Int, used for the signal strength of the peripheral
}
