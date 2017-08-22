//
//  IndexPath+Utils.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//
import Foundation

extension IndexPath {
    func nextInSection() -> IndexPath {
        return IndexPath(row: row + 1, section: 0)
    }
}

