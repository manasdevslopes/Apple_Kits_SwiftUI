//
//  PlayerView.swift
//  Pip Player
//
//  Created by MANAS VIJAYWARGIYA on 18/12/24.
//

import SwiftUI

struct PlayerView: View {
  @StateObject var playerController = PlayerController()
  @State private var title: String = ""
  @State private var link: String = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
  @State private var artist: String = ""
  @State private var isKeyboardVisible: Bool = false
  
  private var isDisabled: Bool {
    title.isEmpty || link.isEmpty || artist.isEmpty
  }
  
  var body: some View {
    VStack(alignment: .center) {
      // Form the input fields and button
      Form {
        Section(header: Text("Video Details")) {
          TextField("Title", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
          TextField("Link", text: $link).textFieldStyle(RoundedBorderTextFieldStyle())
          TextField("Artist", text: $artist).textFieldStyle(RoundedBorderTextFieldStyle())
          Button {
            playerController.initPlayer(title: title, link: link, artist: artist, artwork: "Artist")
          } label: {
            Text("Load Video").frame(maxWidth: .infinity).frame(height: 25)
          }
          .tint(.blue).buttonStyle(.bordered).padding(.top, 8).disabled(isDisabled)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
      }
      .scrollContentBackground(.hidden) // Hide the default background
      .background(.clear) // Set the background to clear
      .cornerRadius(10)
      .padding(.top)
      
      // Use Geometry Reader to adapt to the available space
      if !isKeyboardVisible {
        GeometryReader { geometry in
          let parentWidth = geometry.size.width
          
          // Display loading message if the payer is not initialized yet.
          if playerController.player == nil {
            ContentUnavailableView {
              Label("No Video Loaded", systemImage: "video.slash")
            } description: {
              Text("Please load a video to start playing")
            }
            .frame(width: parentWidth, height: 380)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
          } else {
            // Display VideoPlayer if the payer is initialized.
            VideoPlayer(playercontroller: playerController)
              .frame(width: parentWidth, height: 380)
          }
        }
        .frame(height: 380)
        
        // Play & Pause Button
        HStack {
          Button {
            playerController.playPlayer()
          } label: {
            Text("Play Video").frame(maxWidth: .infinity).frame(minHeight: 25)
          }
          .tint(.green).buttonStyle(.bordered).disabled(playerController.player == nil)
          
          Button {
            playerController.pausePlayer()
          } label: {
            Text("Pause video").frame(maxWidth: .infinity).frame(minHeight: 25)
          }
          .tint(.red).buttonStyle(.bordered).disabled(playerController.player == nil)
        }
        .padding(.horizontal)
      }
    }
    .navigationTitle("Video Player")
    .onAppear {
      NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
        isKeyboardVisible = true
      }
      NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
        isKeyboardVisible = false
      }
    }
    .onDisappear {
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // Initialize the player on view appear
//    .onAppear {
//      playerController.initPlayer(
//        title: "SomeTitle",
//        link: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
//        artist: "Khondakar Afridi",
//        artwork: "Artist"
//      )
//    }
  }
}

#Preview {
  NavigationStack {
    PlayerView()
  }
}
