//
//  ChatCell.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit

final class ChatCell: UITableViewCell {
    
    var progress: Double = 0 {
        didSet {
            playView.progress = progress
        }
    }
    
    fileprivate var chatBubbleView: ChatBubbleView?
    fileprivate let senderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()
    
    fileprivate let senderAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    fileprivate let playView: PlayView = PlayView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(senderLabel)
        contentView.addSubview(senderAvatar)
        contentView.addSubview(playView)
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
        playView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = [
            "chatBubbleView": chatBubbleView,
            "senderLabel": senderLabel,
            "senderAvatar": senderAvatar,
            "playView": playView
            
        ]
        var constraints = [
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[senderLabel][chatBubbleView]|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:[senderAvatar(25)]|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=5)-[playView(35)]-(>=5)-|", options: [], metrics: nil, views: views),
            [NSLayoutConstraint.init(item: playView, attribute: .centerY, relatedBy: .equal, toItem: chatBubbleView, attribute: .centerY, multiplier: 1, constant: 1)]
        ]
        switch(sender) {
        case .sent:
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:[senderLabel]-(40)-|", options: [], metrics: nil, views: views))
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(64)-[chatBubbleView]|", options: [], metrics: nil, views: views))
        case .received:
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(40)-[senderLabel]", options: [], metrics: nil, views: views))
            constraints.append(NSLayoutConstraint.constraints(withVisualFormat: "H:|[senderAvatar(25)][chatBubbleView]-[playView(35)]-(64)-|", options: [], metrics: nil, views: views))
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
        progress = viewModel.audioProgress
        if viewModel.origin == .sent {
            senderLabel.isHidden = true
            senderAvatar.isHidden = true
            playView.isHidden = true
        } else {
            senderLabel.isHidden = false
            senderAvatar.isHidden = false
            playView.isHidden = false
        }
        
        if let image = viewModel.avatarImage {
            senderAvatar.image = image
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

