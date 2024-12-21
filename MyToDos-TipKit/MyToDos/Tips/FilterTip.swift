//
//  FilterTip.swift
//  MyToDos
//
//  Created by MANAS VIJAYWARGIYA on 21/12/24.
//

import Foundation
import TipKit

struct FilterTip: Tip {
  
  static let showFilterTipEvent = Event(id: "showFilterTipEvent")
  var title: Text {
    Text("Search and filter with tags.")
  }
  
  var message: Text? {
    Text("Start your ToDos with a word surrounded by brackets like [Work] so you can effectively filter your ToDo list.")
  }
  
  var image: Image? {
    Image(systemName: "tag.fill")
  }
  
  var actions: [Action] {
    [
      Action(id: "learn-more", title: "Learn More")
    ]
  }
  
  var rules: [Rule] {
    [
      #Rule(Self.showFilterTipEvent) {
        $0.donations.count >= 4
      }
    ]
  }
}

