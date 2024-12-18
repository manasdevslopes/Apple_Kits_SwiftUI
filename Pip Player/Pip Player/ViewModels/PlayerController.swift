//
//  PlayerController.swift
//  Pip Player
//
//  Created by MANAS VIJAYWARGIYA on 18/12/24.
//

import Foundation
import AVKit

class PlayerController: ObservableObject {
  // MARK: - Published properties
  // Published properties to trigger UI updates when changed
  @Published var playbackVideoLink: String = ""
  @Published var playbackTitle: String = ""
  @Published var playbackArtist: String = ""
  @Published var playbackArtwork: String = ""
  
  // MARK: - AVPlayer and AVPlayerViewController Properties
  var player: AVPlayer?
  var avPlayerViewController: AVPlayerViewController = AVPlayerViewController()
  
  // MARK: - Initialization and Setup
  func initPlayer(title: String, link: String, artist: String, artwork: String) {
    // Initialize playback properties
    self.playbackTitle = title
    self.playbackArtist = artist
    self.playbackArtwork = artwork
    self.playbackVideoLink = link
    
    // Setup AVPlayer and AVPlayerViewController
    setupPlayer()
    setupAVPlayerViewController()
  }
}

// MARK: - AVPlayer Setup
extension PlayerController {
  private func setupPlayer() {
    // Initialize AVPlayer with the provided video link
    guard let url = URL(string: playbackVideoLink) else { return }
    player = AVPlayer(url: url)
    
    // Set up metadata for the current item
    setupMetadata()
  }
  
  // Set up metadata for the current AVPlayerItem
  private func setupMetadata() {
    let title = AVMutableMetadataItem()
    title.identifier = .commonIdentifierTitle
    title.value = playbackTitle as NSString
    title.extendedLanguageTag = "und"
    
    let artist = AVMutableMetadataItem()
    artist.identifier = .commonIdentifierArtist
    artist.value = playbackArtist as NSString
    artist.extendedLanguageTag = "und"
    
    let artwork = AVMutableMetadataItem()
    setupArtworkMetadata(artwork)
    
    // Set external metadata for the current AVPlayerItem
    player?.currentItem?.externalMetadata = [title, artist, artwork]
  }
  
  // Set up artwork metadata based on UIImage
  private func setupArtworkMetadata(_ artwork: AVMutableMetadataItem) {
    if let image = UIImage(named: playbackArtwork) {
      if let imageData = image.jpegData(compressionQuality: 1.0) {
        artwork.identifier = .commonIdentifierArtwork
        artwork.value = imageData as NSData
        artwork.dataType = kCMMetadataBaseDataType_JPEG as String
        artwork.extendedLanguageTag = "und"
      }
    }
  }
}

// MARK: - AVPlayerViewController Setup
extension PlayerController {
  private func setupAVPlayerViewController() {
    // Assign AVPlayer to AVPlayerViewController
    avPlayerViewController.player = player
    avPlayerViewController.allowsPictureInPicturePlayback = true
    avPlayerViewController.canStartPictureInPictureAutomaticallyFromInline = true
  }
}

// MARK: - Playback Control
extension PlayerController {
  // Pause the AVPlayer
  func pausePlayer() {
    player?.pause()
  }
  
  // Play the AVPlayer
  func playPlayer() {
    player?.play()
  }
}
