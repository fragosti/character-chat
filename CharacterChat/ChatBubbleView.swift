//
//  ChatBubbleView.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit

final class ChatBubbleView: UIView {
    let message: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
        layer.masksToBounds = true
        addSubview(message)
        installConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewModelConfigurable
extension ChatBubbleView: ViewModelConfigurable {
    convenience init(viewModel: ChatBubbleViewModel) {
        self.init()
        configure(with: viewModel)
    }
    
    func configure(with viewModel: ChatBubbleViewModel) {
        message.text = viewModel.text
        message.textColor = viewModel.style.textColor
        backgroundColor = viewModel.style.color
    }
}

// MARK: - Private Helpers
private extension ChatBubbleView {
    func installConstraints() {
        message.translatesAutoresizingMaskIntoConstraints = false
        let views = ["message": message]
        
        let constraints = [
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-(16)-[message]-(16)-|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-(12)-[message]-(12)-|", options: [], metrics: nil, views: views),
        ].flatMap { $0 }
        
        constraints.activate()
    }
}
