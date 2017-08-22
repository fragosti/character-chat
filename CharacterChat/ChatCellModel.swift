//
//  ChatCellModel.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

let userCellIdentifier = "UserCell"
let characterCellIdentifier = "CharacterCell"
let chatCellIdentifiers = [userCellIdentifier, characterCellIdentifier]

class ChatCellModel {
    
    let sender: ChatLine.Sender
    let chatBubbleViewModel: ChatBubbleViewModel
    let soundFileUri: String?
    var didPlayAudio: Bool = false
    
    var reuseIdentifier: String {
        switch(sender) {
        case .user:
            return userCellIdentifier
        case .character:
            return characterCellIdentifier
        }
    }
    
    init(sender: ChatLine.Sender, chatBubbleViewModel: ChatBubbleViewModel, soundFileUri: String? = nil) {
        self.sender = sender
        self.chatBubbleViewModel = chatBubbleViewModel
        self.soundFileUri = soundFileUri
    }
}

// MARK: - ViewModel
extension ChatCellModel: ViewModel {
    typealias ViewType = ChatCell
}

