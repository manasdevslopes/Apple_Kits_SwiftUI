//
//  SwipeActionTip.swift
//  MyToDos
//
//  Created by MANAS VIJAYWARGIYA on 21/12/24.
//

import Foundation
import TipKit

struct SwipeActionTip: Tip {
  static let swipeActionEvent = Event(id: "swipeActionEvent")
  
  var options: [TipOption] {
    [
      Tips.MaxDisplayCount(1),
      Tips.IgnoresDisplayFrequency(true),
    ]
  }
  
  var title: Text {
    Text("Swipe Actions")
  }
  
  var message: Text? {
    Text("Swipe from leading edge to mark as completed\nSwipe from trailing edge to delete.")
  }
  
  var image: Image? {
    Image(.noToDos)
  }
  
  var rules: [Rule] {
    [
      #Rule(Self.swipeActionEvent) {event in
        event.donations.count >= 3
      }
    ]
  }
}

