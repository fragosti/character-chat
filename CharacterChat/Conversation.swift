//
//  Conversation.swift
//  CharacterChat
//
//  Created by Francesco Agosti on 8/21/17.
//  Copyright © 2017 fragosti. All rights reserved.
//

import Foundation
import UIKit

class Conversation: NSObject {
    
    var models: [ChatCellModel]
    var place: Int
    
    var totalLength: Int {
        return models.count
    }
    
    init(models: [ChatCellModel], place: Int = 1) {
        self.models = models
        self.place = place
    }
    
    func isLastModel(for row: Int) -> Bool {
        return row == totalLength - 1
    }
    
    func isUserModel(for row: Int) -> Bool {
        return models[row].sender == .user
    }
    
    func isLastVisibleModel(for row: Int) -> Bool {
        return row == place - 1
    }
}

// MARK: - TableViewDatasource
extension Conversation: TableViewDatasource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseIdentifier) as! ChatCell
        cell.configure(with: model)
        return cell
    }
}
