//
//  ContactView.swift
//  Contact
//
//  Created by MANAS VIJAYWARGIYA on 21/12/24.
//

import Contacts
import SwiftUI

struct ContactView: View {
  @State private var contacts: [CNContact] = []
  @State private var myCardContact: CNContact?
  @State private var isAuthorized: Bool = false
  @State private var isDenied: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        if isAuthorized {
          if let contact = myCardContact {
            HStack {
              if let imageData = contact.imageData, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                  .resizable().aspectRatio(contentMode: .fill).frame(width: 100, height: 100).clipShape(Circle())
              } else {
                Circle().fill(Color.gray).frame(width: 100, height: 100)
              }
              
              VStack(alignment: .leading) {
                Text("\(contact.givenName) \(contact.familyName)").font(.headline)
                Text(contact.phoneNumbers.first?.value.stringValue ?? "").font(.subheadline)
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
          } else {
            Text("No My Card Contact found.")
          }
          List {
            Divider().listRowSeparator(.hidden)
            ForEach(contacts, id: \.identifier) { contactDetail in
              HStack(spacing: 10) {
                if let imageData = contactDetail.imageData, let uiImage = UIImage(data: imageData) {
                  Image(uiImage: uiImage)
                    .resizable().frame(width: 50, height: 50).clipShape(Circle())
                } else {
                  Image(systemName: "person.crop.circle.fill")
                    .resizable().frame(width: 50, height: 50).foregroundColor(.gray)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                  Text("\(contactDetail.givenName)")
                  Text("\(contactDetail.familyName)")
                    .font(.footnote).foregroundStyle(.gray)
                  if let phoneNumber = contactDetail.phoneNumbers.first?.value.stringValue {
                    Text(phoneNumber).font(.footnote).foregroundStyle(.gray)
                  }
                }.multilineTextAlignment(.leading)
                
                Spacer()
                Image(systemName: "phone.fill")
                  .resizable().frame(width: 30, height: 30)
                  .onTapGesture {
                    if let phoneNumber = contactDetail.phoneNumbers.first?.value.stringValue {
                      callNumber(phoneNumber: phoneNumber)
                    }
                  }
              }
            }
          }
          .listStyle(.plain)
        } else {
          ContentUnavailableView {
            if isDenied {
              VStack {
                Text("Contact access is required to display your contacts.")
                  .font(.title2)
                  .multilineTextAlignment(.center)
                  .padding()
                
                Text("You have denied access to contacts. Please enable access in Settings.")
                  .foregroundColor(.red)
                  .padding()
                
                Button(action: {
                  openSettings()
                }) {
                  Text("Open Settings")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Capsule().strokeBorder(Color.blue, lineWidth: 2))
                }
              }
            }
            else if contacts.isEmpty && !isDenied {
              Text("Loading...")
            }
          }
        }
      }
      .transition(.slide)
      .onAppear(perform: getContactList)
      .navigationTitle("Contacts")
    }
  }
  
  private func getContactList() {
    DispatchQueue.global(qos: .userInitiated).async {
      let CNStore = CNContactStore()
      switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
          do {
            /* For All Contacts in the Phone list */
            let keys = [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keys)
            var fetchedContacts: [CNContact] = []
            try CNStore.enumerateContacts(with: request) { contact, _ in
              fetchedContacts.append(contact)
            }
            DispatchQueue.main.async {
              contacts = fetchedContacts.sorted(by: { $0.givenName < $1.givenName })
              isAuthorized = true
              isDenied = false
            }
            /* For My Card */
            let predicateMyCard = CNContact.predicateForContacts(matchingName: "Manas")
            let contactsMyCard = try CNStore.unifiedContacts(matching: predicateMyCard, keysToFetch: keys)
            if let myCard = contactsMyCard.first(where: {
              $0.isKeyAvailable(CNContactPhoneNumbersKey) && $0.isKeyAvailable(CNContactGivenNameKey)
              && $0.isKeyAvailable(CNContactFamilyNameKey)
            }) {
              DispatchQueue.main.async {
                myCardContact = myCard
              }
            }
          } catch {
            print("Error on Contact fetching: \(error)")
          }
        case .denied: print("denied")
          DispatchQueue.main.async {
            isDenied = true
            isAuthorized = false
          }
        case .notDetermined:
          print("not determined")
          CNStore.requestAccess(for: .contacts) { granted, error in
            if granted {
              getContactList()
            } else if let error {
              print("Error requesting contact access: \(error)")
              DispatchQueue.main.async {
                isDenied = true // Mark as denied when the user has not yet determined permission
                isAuthorized = false
              }
            }
          }
        case .restricted: print("restricted")
        case .limited: print("limited")
        @unknown default: print("")
      }
    }
  }
  
  private func fetchMyCardContacts() {
    let store = CNContactStore()
    store.requestAccess(for: .contacts) { granted, error in
      if granted {
        isAuthorized = true
        let keysToFetch = [
          CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,
          CNContactImageDataKey, CNContactEmailAddressesKey
        ] as [CNKeyDescriptor]
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: store.defaultContainerIdentifier())
        do {
          let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
          if let myCard = contacts.first(where: { $0.contactType == .person && $0.isKeyAvailable(CNContactPhoneNumbersKey) }) {
            DispatchQueue.main.async {
              myCardContact = myCard
            }
          }
        } catch {
          print("Failed to fetch My Card Contacts: \(error)")
        }
      } else {
        isAuthorized = false
      }
    }
  }
  
  private func callNumber(phoneNumber: String) {
    if let phoneUrl = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneUrl) {
      UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
    }
  }
  
  private func openSettings() {
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
  }
}

#Preview {
  ContactView()
}
