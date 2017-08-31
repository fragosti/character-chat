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
    let senderLabel: UILabel = UILabel()
    let senderAvatar: UIImageView = {
        let avatar = UIImage(named: "avatar")
        let imageView = UIImageView(image: avatar)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(senderLabel)
        contentView.addSubview(senderAvatar)
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
        senderLabel.translatesAutoresizingMaskIntoConstraints = false
        senderAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        let views = [
            "chatBubbleView": chatBubbleView,
            "senderLabel": senderLabel,
            "senderAvatar": senderAvatar,
        ]
        var constraints = [
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[senderLabel][chatBubbleView]|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:[senderAvatar(25)]|", options: [], metrics: nil, views: views),
        ]
        switch(sender) {
        case .sent:
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:[senderLabel]-(32)-|", options: [], metrics: nil, views: views))
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(64)-[chatBubbleView]|", options: [], metrics: nil, views: views))
        case .received:
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(32)-[senderLabel]", options: [], metrics: nil, views: views))
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:|[senderAvatar(25)][chatBubbleView]-(64)-|", options: [], metrics: nil, views: views))
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
        senderLabel.text = viewModel.sender.name
        if viewModel.origin == .sent {
            senderLabel.isHidden = true
            senderAvatar.isHidden = true
        }
        
        if let bubbleView = chatBubbleView {
            bubbleView.configure(with: viewModel.chatBubbleViewModel)
        } else {
            chatBubbleView = viewModel.chatBubbleViewModel.makeView()
            contentView.addSubview(chatBubbleView!)
            installConstraints(for: viewModel.origin)
        }
    }
}

