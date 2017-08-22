//
//  Array+Utils.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/19/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit

extension Array where Element: NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}
