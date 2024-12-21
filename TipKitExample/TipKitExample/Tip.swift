//
//  Tip.swift
//  TipKitExample
//
//  Created by MANAS VIJAYWARGIYA on 21/12/24.
//

import Foundation
import TipKit

struct AddColorTip: Tip {
  var title: Text {
    Text("Add New Color").foregroundStyle(.teal)
  }
  
  var message: Text? {
    Text("Tap here to add a new color to the list")
  }
  
  var image: Image? {
    Image(systemName: "paintpalette")
  }
}

struct SetFavoriteTip: Tip {
  static let setFavoriteEvent = Event(id: "setFavorite")
  static let colorsViewVisitedEvent = Event(id: "colorsViewVisited")
  
  var title: Text {
    Text("Set Favorites")
  }
  
  var message: Text? {
    Text("Tap and hold a color to add it to your favorite")
  }
  
  var rules: [Rule] {
    // Show this rule when we never set a Favorite before
    #Rule(Self.setFavoriteEvent) { event in
      event.donations.count == 0
    }
    // Also, Show this rule when we visited lets say 2 times for eg.
    #Rule(Self.colorsViewVisitedEvent) { event in
      event.donations.count > 2
    }
  }
}
