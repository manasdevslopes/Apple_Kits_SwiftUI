//
//  ContentView.swift
//  BluetoothApp
//
//  Created by MANAS VIJAYWARGIYA on 23/12/24.
//

import SwiftUI
import CoreBluetooth

struct ContentView: View {
  @StateObject private var bleManager = BLEManager()
  
  var body: some View {
    VStack(spacing: 10) {
      Text("Bluetooth Devices")
        .font(.largeTitle).frame(maxWidth: .infinity, alignment: .center)
      
      List(bleManager.peripherals) {peripheral in
        HStack {
          Text(peripheral.name)
          Spacer()
          Text(String(peripheral.rssi))
          Button {
            bleManager.connect(to: peripheral)
          } label: {
            if bleManager.connectedPeripheralUUID == peripheral.id {
              Text("Connected").foregroundStyle(.green)
            } else {
              Text("Connect")
            }
          }
        }
      }
      .frame(height: UIScreen.main.bounds.height / 2)
      
      Spacer()
      
      Text("STATUS").font(.headline)
      
      if bleManager.isSwitchedOn {
        Text("Bluetooth is switched on").foregroundStyle(.green)
      } else {
        Text("Bluetooth is NOT switched on").foregroundStyle(.red)
      }
      
      Spacer()
      
      VStack(spacing: 25) {
        Button {
          bleManager.startScanning()
        } label: {
          Text("Start Scanning")
        }
        
        Button {
          bleManager.stopScanning()
        } label: {
          Text("Stop Scanning")
        }
      }
      .padding()
      .buttonStyle(.borderedProminent)
      
      Spacer()
    }
    .onAppear {
      if bleManager.isSwitchedOn {
        bleManager.startScanning()
      }
    }
  }
}

#Preview {
  ContentView()
}
