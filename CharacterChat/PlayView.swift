//
//  PlayView.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/30/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit
import CircleProgressView

protocol PlayViewDelegate: class {
    func didPressPlay()
}

class PlayView: UIView {

    var progress: Double = 0 {
        didSet {
            if progress == 0 {
                progressView.isHidden = true
                playView.isHidden = false
            } else {
                progressView.isHidden = false
                playView.isHidden = true
            }
            progressView.setProgress(progress, animated: oldValue < progress)
        }
    }
    
    weak var delegate: PlayViewDelegate?
    
    let playView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play-button"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didPlay), for: .touchUpInside)
        return button
    }()
    
    let progressView: CircleProgressView = {
        let progress = CircleProgressView()
        progress.trackWidth = 3
        progress.backgroundColor = UIColor.white
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
    
    @objc func didPlay() {
        delegate?.didPressPlay()
    }
}
