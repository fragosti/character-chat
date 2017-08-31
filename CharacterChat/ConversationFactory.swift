//
//  ConversationFactory.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit

let characterScript = [
    "Hello, how are you?",
    "I'm good, thanks for asking. What is your name?",
    "My name is Kyle. What are you up to today?",
    "Well you seem to be doing pretty well!",
    "How long have you been learning English?",
    "I'm sure you'll be fluent in no time."
]

let userScript = [
    "I'm doing great. What about you?",
    "My name is Jack. What is your name?",
    "I'm just trying to learn English",
    "Thank you!",
    "I've just started learning English",
    "I hope so! Good thing I have this app to help.",
]

struct ChatLine {
    enum Origin {
        case sent
        case received
    }
    let origin: Origin
    let line: String
    let sender: Sender
    let soundFileUri: String?
}

struct Sender {
    let name: String
    let avatarImgPath: String
}

// This would be fetched from a server or just defined in text/json files, but definining in this way for convenience.
func createChatLines() -> [ChatLine] {
    let userSender = Sender(name: "Jack", avatarImgPath: "")
    let characterSender = Sender(name: "Kyle", avatarImgPath: "")
    let userChatLines = userScript.map { ChatLine(origin: .sent, line: $0, sender: userSender, soundFileUri: nil) }
    let characterChatLines = characterScript.enumerated().map { ChatLine(origin: .received, line: $1, sender: characterSender, soundFileUri: "\($0+1)" ) }
    return zip(characterChatLines, userChatLines).map { [$0, $1] }.flatMap { $0 }
}


class ConversationFactory {
    
    static func createConversation(from lines: [ChatLine]) ->  Conversation {
        let models = lines.map { ChatCellModel(line: $0) }
        return Conversation(models: models)
    }
    
    static func defaultConversation() -> Conversation {
        return createConversation(from: createChatLines())
    }
}
