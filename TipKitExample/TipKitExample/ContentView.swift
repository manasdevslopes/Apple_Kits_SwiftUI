//
//  ContentView.swift
//  TipKitExample
//
//  Created by MANAS VIJAYWARGIYA on 21/12/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
  @State private var colors = MockData.colors
  let addColorTip = AddColorTip()
  let setFavoriteTip = SetFavoriteTip()
  
    var body: some View {
      NavigationStack {
        ScrollView {
          TipView(setFavoriteTip).tipBackground(.teal.opacity(0.2))
          ForEach(colors, id: \.self) {
            RoundedRectangle(cornerRadius: 10)
              .fill($0.gradient).frame(height: 100)
              .contextMenu {
                Button("Favorite", systemImage: "star") {
                  // Code to set as Fovorite - use any code like userdefault, AppStorage, CoreData, SwiftData
                  // But to trigger the rule to show SetFavoriteTip Tip with this event - Self.setFavoriteEvent
                  Task { await SetFavoriteTip.setFavoriteEvent.donate() } 
                }
              }
          }
        }
        .padding()
        .navigationTitle("Colors")
        .toolbar {
          Button {
            colors.insert(.random, at: 0)
            addColorTip.invalidate(reason: .actionPerformed)
          } label: {
            Image(systemName: "plus")
          }
          .popoverTip(addColorTip)
        }
        .onAppear {
          Task { await SetFavoriteTip.colorsViewVisitedEvent.donate() }   
        }
      }
    }
}

#Preview {
    ContentView()
    .task {
      try? Tips.resetDatastore() 
      try? Tips.configure([
        .displayFrequency(.immediate),
        .datastoreLocation(.applicationDefault)
      ])
    }
}

extension Color {
  static var random: Color {
    return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
  }
}

struct MockData {
  static let colors = [Color.random, Color.random, Color.random, Color.random]
}
