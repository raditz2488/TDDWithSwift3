//
//  ItemCell.swift
//  ToDo
//
//  Created by Rohan Bhale on 12/06/17.
//  Copyright © 2017 RB. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    func configCell(with item: ToDoItem, checked: Bool = false) {
        if checked {
            let attributedString = NSAttributedString(string: item.title, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
            
            titleLabel.attributedText = attributedString
            locationLabel.text = nil
            dateLabel.text = nil
        } else {
            titleLabel.text = item.title
            locationLabel.text = item.location?.name
            
            if let timeStamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timeStamp)
                dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
}
