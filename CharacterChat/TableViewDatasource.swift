//
//  TableViewDatasource.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import UIKit

protocol TableViewDatasource: UITableViewDataSource {
    associatedtype ModelType
    var models: [ModelType] { get set }
}
