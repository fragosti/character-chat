//
//  ChatCellModel.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit

let userCellIdentifier = "UserCell"
let characterCellIdentifier = "CharacterCell"
let chatCellIdentifiers = [userCellIdentifier, characterCellIdentifier]

class ChatCellModel {
    
    static let sentBubbleStyle = ChatBubbleViewModel.Style(color: UIColor.gray, textColor: UIColor.white)
    static let receivedBubbleStyle = ChatBubbleViewModel.Style(color: UIColor.blue, textColor: UIColor.black)
    
    let origin: ChatLine.Origin
    let sender: Sender
    let chatBubbleViewModel: ChatBubbleViewModel
    let soundFileUri: String?
    var didPlayAudio: Bool = false
 
    
    var reuseIdentifier: String {
        switch(origin) {
        case .sent:
            return userCellIdentifier
        case .received:
            return characterCellIdentifier
        }
    }
    
    init(origin: ChatLine.Origin, sender: Sender, chatBubbleViewModel: ChatBubbleViewModel, soundFileUri: String? = nil) {
        self.origin = origin
        self.sender = sender
        self.chatBubbleViewModel = chatBubbleViewModel
        self.soundFileUri = soundFileUri
    }
    
    convenience init(line: ChatLine) {
        let style = line.origin == .sent ? ChatCellModel.sentBubbleStyle : ChatCellModel.receivedBubbleStyle
        let chatBubbleViewModel = ChatBubbleViewModel(text: line.line, style: style)
        self.init(origin: line.origin, sender: line.sender, chatBubbleViewModel: chatBubbleViewModel, soundFileUri: line.soundFileUri)
    }
}

// MARK: - ViewModel
extension ChatCellModel: ViewModel {
    typealias ViewType = ChatCell
}

