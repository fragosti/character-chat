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
    
    static let sentBubbleStyle = ChatBubbleViewModel.Style(color: UIColor(red: 0.95, green: 0.94, blue: 0.94, alpha: 1.0), textColor: UIColor.black)
    static let receivedBubbleStyle = ChatBubbleViewModel.Style(color: UIColor(red: 0.00, green: 0.52, blue: 1.00, alpha: 1.0), textColor: UIColor.white)
    
    let origin: ChatLine.Origin
    let sender: Sender
    let chatBubbleViewModel: ChatBubbleViewModel
    let soundFileUri: String?
    let avatarImage: UIImage?
    var didPlayAudio: Bool = false
    var audioProgress: Double
 
    
    var reuseIdentifier: String {
        switch(origin) {
        case .sent:
            return userCellIdentifier
        case .received:
            return characterCellIdentifier
        }
    }
    
    init(origin: ChatLine.Origin, sender: Sender, chatBubbleViewModel: ChatBubbleViewModel, soundFileUri: String? = nil, avatarImage: UIImage? = nil, audioProgress: Double = 0) {
        self.origin = origin
        self.sender = sender
        self.chatBubbleViewModel = chatBubbleViewModel
        self.soundFileUri = soundFileUri
        self.avatarImage = avatarImage
        self.audioProgress = audioProgress
    }
    
    convenience init(line: ChatLine) {
        let style = line.origin == .sent ? ChatCellModel.sentBubbleStyle : ChatCellModel.receivedBubbleStyle
        let image = line.sender.avatarImgPath == nil ? nil : UIImage(named: line.sender.avatarImgPath!)
        let chatBubbleViewModel = ChatBubbleViewModel(text: line.line, style: style)
        self.init(origin: line.origin, sender: line.sender, chatBubbleViewModel: chatBubbleViewModel, soundFileUri: line.soundFileUri, avatarImage: image)
    }
}


// MARK: - ViewModel
extension ChatCellModel: ViewModel {
    typealias ViewType = ChatCell
}

