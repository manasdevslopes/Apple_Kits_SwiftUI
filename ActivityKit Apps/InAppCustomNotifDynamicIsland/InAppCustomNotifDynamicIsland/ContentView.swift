//
// ContentView.swift
// InAppCustomNotifDynamicIsland
//
// Created by MANAS VIJAYWARGIYA on 05/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  @State private var adaptDynamic: Bool = true
  @State private var showSheet: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        Toggle("Adapt For Dynamic Island", isOn: $adaptDynamic)
        HStack {
          Button {
            self.showSheet.toggle()
          } label: {
            Text("Show Sheet")
          }
          .tint(.pink)
          .sheet(isPresented: $showSheet) {
            Button("Show AirDrop Notification") {
              UIApplication.shared.inAppNotification(adaptForDynamicIsland: adaptDynamic, timeOut: 5, swipeToClose: true) {
                HStack {
                  Image(systemName: "wifi").font(.system(size: 40)).foregroundStyle(.white)
                  
                  VStack(alignment: .leading, spacing: 2) {
                    Text("AirDrop").font(.caption.bold()).foregroundStyle(.white)
                    Text("From Manas").textScale(.secondary).foregroundStyle(.gray)
                  }
                  .padding(.top, 20)
                  
                  Spacer(minLength: 0)
                }
                .padding(15)
                .background {
                  RoundedRectangle(cornerRadius: 15).fill(.black)
                }
              }
            }
            .tint(.pink)
            .buttonStyle(.bordered)
          }
          
          Button("Show Notification") {
            UIApplication.shared.inAppNotification(adaptForDynamicIsland: adaptDynamic, timeOut: 5, swipeToClose: true) {
              HStack {
                Image("manas_iosdev").resizable().aspectRatio(contentMode: .fill)
                  .frame(width: 40, height: 40).clipShape(.circle)
                VStack(alignment: .leading, spacing: 6) {
                  Text("manas_iosdev").font(.caption.bold()).foregroundStyle(.white)
                  Text("Hello, this is Manas Vijaywargiya!").textScale(.secondary).foregroundStyle(.gray)
                }
                .padding(.top, 20)
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                  Image(systemName: "speaker.slash.fill").font(.title2)
                }
                .buttonStyle(.bordered).buttonBorderShape(.circle)
                .tint(.white)
              }
              .padding(15)
              .background {
                RoundedRectangle(cornerRadius: 15).fill(.black)
              }
            }
          }
          .tint(.blue)
        }
      }
      .buttonStyle(.bordered)
      .padding()
      .navigationTitle("In App Notification's")
    }
  }
}

#Preview {
  ContentView()
}
