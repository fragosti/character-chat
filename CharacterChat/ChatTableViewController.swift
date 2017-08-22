//
//  ChatTableViewController.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit

class ChatTableViewController: UITableViewController {
    
    let conversation: Conversation
    var player: AudioPlayerProtocol
    
    init(conversation: Conversation, player: AudioPlayerProtocol = AudioPlayer()) {
        self.conversation = conversation
        self.player = player
        super.init(nibName: nil, bundle: nil)
        configureTableView(conversation: conversation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate
extension ChatTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = conversation.models[indexPath.row]
        if shouldShowNextLine(from: indexPath.row) {
            showNextLine(from: indexPath)
        }
        playAudio(from: model, onCompletion: { (didSucceed) in
            // If the user didn't finish playing the auto-play, we should show the next line on this completion.
            if !model.didPlayAudio {
                self.showNextLine(from: indexPath)
                model.didPlayAudio = true
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let model = conversation.models[indexPath.row]
        // Only auto-play once
        if !model.didPlayAudio {
            playAudio(from: model, onCompletion: { (didSucceed) in
                self.showNextLine(from: indexPath)
                model.didPlayAudio = true
            })
        }
    }
}

// MARK: - Private Helpers
private extension ChatTableViewController {
    
    func shouldShowNextLine(from row: Int) -> Bool {
        return conversation.isLastVisibleModel(for: row) && !conversation.isLastModel(for: row) && conversation.isUserModel(for: row)
    }
    
    func showNextLine(from indexPath: IndexPath) {
        conversation.place += 1
        tableView.insertRows(at: [indexPath.nextInSection()], with: .automatic)
    }
    
    func playAudio(from model: ChatCellModel, onCompletion: AudioPlayer.CompletionHandler? = nil) {
        if let resource = model.soundFileUri {
            player.resource = resource
            player.onCompletion = onCompletion
            player.play()
        }
    }
    
    func configureTableView(conversation: Conversation) {
        tableView.dataSource = conversation
        tableView.separatorStyle = .none
        chatCellIdentifiers.forEach { tableView.register(ChatCell.self, forCellReuseIdentifier: $0) }
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsetsMake(statusBarHeight, 0, 0, 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }
}


