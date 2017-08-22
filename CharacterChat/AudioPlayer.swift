//
//  AudioPlayer.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import AVFoundation

protocol AudioPlayerProtocol: class {
    /// Bool indicates successful completion or not
    typealias CompletionHandler = (Bool) -> Void
    var resource: String? { get set }
    var onCompletion: CompletionHandler? { get set }
    func play()
    func stop()
}

class AudioPlayer: NSObject {
    
    var resource: String? {
        didSet {
            loadResource()
        }
    }
    var onCompletion: AudioPlayerProtocol.CompletionHandler?
    fileprivate var player: AVAudioPlayer?
}

// MARK: - AudioPlayerProtocol
extension AudioPlayer: AudioPlayerProtocol {

    func play() {
        player?.play()
    }
    
    func stop() {
        player?.stop()
    }
}

// MARK: - AVAudioPlayerDelegate
extension AudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onCompletion?(flag)
    }
}

// MARK: - Private Helpers
private extension AudioPlayer {
    func loadResource() {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "m4a") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
