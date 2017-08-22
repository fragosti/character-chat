//
//  ChatBubbleViewModel.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit

struct ChatBubbleViewModel {
    struct Style {
        let color: UIColor
        let textColor: UIColor
    }
    let text: String
    let style: Style
}

// MARK: - ViewModel
extension ChatBubbleViewModel: ViewModel {
    typealias ViewType = ChatBubbleView
}
