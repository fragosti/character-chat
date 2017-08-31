//
//  ChatCell.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit

final class ChatCell: UITableViewCell {
    
    var chatBubbleView: ChatBubbleView?
 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Helpers
private extension ChatCell {
    func installConstraints(for sender: ChatLine.Origin) {
        guard let chatBubbleView = chatBubbleView else { return }
        chatBubbleView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["chatBubbleView": chatBubbleView]
        var constraints = [
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[chatBubbleView]|", options: [], metrics: nil, views: views),
        ]
        switch(sender) {
        case .sent:
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(64)-[chatBubbleView]|", options: [], metrics: nil, views: views))
        case .received:
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:|[chatBubbleView]-(64)-|", options: [], metrics: nil, views: views))
        }
        constraints.flatMap { $0 }.activate()
    }
}

// MARK: - ViewModelConfigurable
extension ChatCell: ViewModelConfigurable {
    convenience init(viewModel: ChatCellModel) {
        self.init()
        configure(with: viewModel)
    }
    
    func configure(with viewModel: ChatCellModel) {
        if let bubbleView = chatBubbleView {
            bubbleView.configure(with: viewModel.chatBubbleViewModel)
        } else {
            chatBubbleView = viewModel.chatBubbleViewModel.makeView()
            contentView.addSubview(chatBubbleView!)
            installConstraints(for: viewModel.origin)
        }
    }
}

