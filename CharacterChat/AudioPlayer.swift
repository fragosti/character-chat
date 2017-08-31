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
    typealias ProgressHandler = (Double) -> Void
    var resource: String? { get set }
    var onCompletion: CompletionHandler? { get set }
    var onProgress: AudioPlayerProtocol.ProgressHandler? { get set }
    func play()
    func stop()
}

class AudioPlayer: NSObject {
    
    var resource: String? {
        willSet {
            stop()
        }
        didSet {
            loadResource()
        }
    }
    var timer: Timer?
    var onCompletion: AudioPlayerProtocol.CompletionHandler?
    var onProgress: AudioPlayerProtocol.ProgressHandler?
    var player: AVAudioPlayer?
}

// MARK: - AudioPlayerProtocol
extension AudioPlayer: AudioPlayerProtocol {

    func play() {
        player?.play()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            guard let player = self?.player else { return }
            let progress = player.currentTime / player.duration
            self?.onProgress?(progress)
        })
    }
    
    func stop() {
        player?.stop()
        timer?.invalidate()
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
