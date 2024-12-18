//
//  Events.swift
//  Events
//
//  Created by MANAS VIJAYWARGIYA on 18/12/24.
//
// EventKit: Used to interact with the calendar, request access, fetch events, and create/edit events.
// EventKitUI: Used to present the event edit view controller for creating and editing events.
// SwiftUI: Used to build the user interface, including the list of events and the navigation.


import SwiftUI
import EventKit

struct Events: View {
  @State private var events: [EKEvent] = []
  @State private var eventStore = EKEventStore()
  @State private var showingAddEventView: Bool = false
  @State private var accessGranted: Bool = false
  
  var body: some View {
    NavigationStack {
      if accessGranted {
        List {
          ForEach(groupedEventsByDate().sorted(by: { $0.key < $1.key }), id: \.key) { date, events in
            Section {
              ForEach(events, id: \.eventIdentifier) { event in
                EventRow(event: event)
              }
              .onDelete { indexSet in
                deleteEvent(at: indexSet, in: events)
              }
            } header: {
              Text(date, style: .date).font(.headline)
            }
            
          }
        }
        .navigationTitle("Events")
        .toolbar {
          Button {
            showingAddEventView = true
          } label: {
            Image(systemName: "plus")
          }
        }
        .sheet(isPresented: $showingAddEventView) {
          AddEventView(eventStore: eventStore) { newEvent in
            if let newEvent {
              events.append(newEvent)
              events.sort(by: { $0.startDate < $1.startDate })
            }
          }
        }
      } else {
        ContentUnavailableView {
          Label("Calendar Access Required", systemImage: "calendar.badge.exclamationmark")
        } description: {
          Text("Calender access is not granted. Please enable access in Settings.")
        } actions: {
          Button(action: openSettings) {
            Text("Open Settings")
              .frame(width: 250, height: 31)
          }
          .tint(.green).buttonStyle(.bordered)
        }
        .navigationTitle("Access Required")
      }
    }
    .onAppear(perform: requestAccessToCalendar)
  }
}

extension Events {
  private func requestAccessToCalendar() {
    eventStore.requestFullAccessToEvents { granted, error in
      self.accessGranted = granted
      if granted {
        fetchEvents()
      } else if let error {
        print("Error requesting access to calendar: \(error)")
      }
    }
  }
  
  private func fetchEvents() {
    let calendars = eventStore.calendars(for: .event)
    let oneMonthAgo = Date().addingTimeInterval(-30*24*60*60)
    let oneMonthAfter = Date().addingTimeInterval(30*24*60*60)
    let predicate = eventStore.predicateForEvents(withStart: oneMonthAgo, end: oneMonthAfter, calendars: calendars)
    
    DispatchQueue.global(qos: .userInitiated).async {
      let fetchedEvents = self.eventStore.events(matching: predicate)
      DispatchQueue.main.async {
        self.events = fetchedEvents.sorted(by: { $0.startDate < $1.startDate })
      }
    }
  }
  
  private func groupedEventsByDate() -> [Date: [EKEvent]] {
    Dictionary(grouping: events) { event in
      Calendar.current.startOfDay(for: event.startDate)
    }
  }
  
  private func deleteEvent(at indexSet: IndexSet, in events: [EKEvent]) {
    guard let index = indexSet.first else { return }
    let event = events[index]
    do {
      try eventStore.remove(event, span: .thisEvent, commit: true)
      self.events.removeAll { $0.eventIdentifier == event.eventIdentifier }
    } catch {
      print("Failed to delete event: \(error)")
    }
  }
  
  private func openSettings() {
    if let url = URL(string: UIApplication.openSettingsURLString) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
}

#Preview {
  Events()
}
