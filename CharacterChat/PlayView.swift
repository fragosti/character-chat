//
//  PlayView.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/30/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit
import CircleProgressView

class PlayView: UIView {
    enum State {
        case play
        case progress(progress:Float)
    }
    
    var state: State = .play {
        didSet {
            // do stuff
        }
    }
    
    let playView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play-button"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let progressView: CircleProgressView = {
        let progress = CircleProgressView()
        progress.isHidden = true
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playView)
        addSubview(progressView)
        installConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PlayView {
    func installConstraints() {
        playView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        let views = [
            "playView": playView,
            "progressView": progressView
        ]
        
        let constraints = [
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[playView]|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[progressView]|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[progressView]|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[playView]|", options: [], metrics: nil, views: views),
        ].flatMap { $0 }
        
        constraints.activate()
    }
}
