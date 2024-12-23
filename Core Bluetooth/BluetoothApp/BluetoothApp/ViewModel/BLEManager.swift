//
//  BLEManager.swift
//  BluetoothApp
//
//  Created by MANAS VIJAYWARGIYA on 23/12/24.
//

import SwiftUI
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
  var myCentral: CBCentralManager! // Declare a variable for the central Manager
  var connectedPeripheral: CBPeripheral?
  @Published var isSwitchedOn = false // if Bluetooth is switched On
  @Published var peripherals = [Peripheral]() // Array to store discovered peripherals
  @Published var connectedPeripheralUUID: UUID? // To store the UUID of the connected peripheral
  
  // Override the init method
  override init() {
    super.init() // call the superClass's initializer
    myCentral = CBCentralManager(delegate: self, queue: nil) // Initialize the central manager with self as delegate
  }
  
  // Delegate method called when state of the central manager is updated (ie Bluetooth is on / off)
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    isSwitchedOn = central.state == .poweredOn
    if isSwitchedOn {
      startScanning() // Start scanning if Bluetooth is powered on
    } else {
      stopScanning() // Stop scanning if Bluetooth is not powered on
    }
  }
  
  // Delegate method called when a peripheral is discovered
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    let newPeripheral = Peripheral(id: peripheral.identifier, name: peripheral.name ?? "Unknown", rssi: RSSI.intValue) // Create a new Peripheral object
    if !peripherals.contains(where: { $0.id == newPeripheral.id }) {// Check if the peripheral is not in the list
      DispatchQueue.main.async {
        self.peripherals.append(newPeripheral) // Append the new peripheral in the list
      }
    }
  }
  
  // Function to start scanning for peripherals
  func startScanning() {
    print("startScanning")
    myCentral.scanForPeripherals(withServices: nil, options: nil) // Start scanning with no specific services
  }
  
  // Function to stop scanning for peripherals
  func stopScanning() {
    print("stopScanning")
    myCentral.stopScan() // Stop scanning
  }
  
  // Function to connect to peripheral
  func connect(to peripheral: Peripheral) {
    guard let cbPeripheral = myCentral.retrievePeripherals(withIdentifiers: [peripheral.id]).first else {
      print("Peripheral not found for connection")
      return
    }
    connectedPeripheralUUID = cbPeripheral.identifier // Set the connected Peripheral's UUID
    connectedPeripheral = cbPeripheral // Store the peripheral in a property to keep a strong reference
    cbPeripheral.delegate = self // Set self as the delegate of the peripheral
    print("Connecting to \(cbPeripheral.name ?? "Unknown")")
    myCentral.connect(cbPeripheral, options: nil) // Connect to the peripheral
  }
  
  // Delegate method is called when a peripheral is connected
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    print("Connected to \(peripheral.name ?? "Unknown")")
    DispatchQueue.main.async {
      self.connectedPeripheralUUID = peripheral.identifier
    }
    peripheral.discoverServices(nil) // Discover services on the connected peripheral
  }
  
  // Delegate method called when the connection to a peripherals fails
  func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
    print("Failed to connect to \(peripheral.name ?? "Unknown") : \(error?.localizedDescription ?? "No error information")")
    if peripheral.identifier == connectedPeripheralUUID { // Check if the failed peripheral is the connected one
      DispatchQueue.main.async {
        self.connectedPeripheralUUID = nil // Clear the connected peripheral UUID
      }
    }
  }
  
  // Delegate method is called when a peripheral is disconnected
  func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    print("Disconnected from \(peripheral.name ?? "Unknown")")
    if peripheral.identifier == connectedPeripheralUUID { // Check if the disconnected peripheral is the connected one
      DispatchQueue.main.async {
        self.connectedPeripheralUUID = nil // Clear the connected peripheral UUID
      }
    }
  }
  
  // Delegate method called when services are discovered on a peripheral
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    if let services = peripheral.services { // Check if the services are discovered
      for service in services { // Iterate through the services
        print("Discovered service \(service.uuid)")
        peripheral.discoverCharacteristics(nil, for: service) // Discover characterisitics for the service
      }
    }
  }
  
  // delegate method called when characteristic are discovered for a service
  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    if let characteristics = service.characteristics { // Check if the characteristic are discovered
      for characteristic in characteristics { // Iterate through the characteristic
        print("Discovered characteristic \(characteristic.uuid)")
        // Interact with characteristic as needed
        peripheral.readValue(for: characteristic)
      }
    }
  }
  
  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    if let error = error {
      print("Error reading characteristic value: \(error.localizedDescription)")
      return
    }
    
    if let value = characteristic.value {
      print("Value for characteristic \(characteristic.uuid): \(value)")
      // Process the value as needed
    }
  }
}
