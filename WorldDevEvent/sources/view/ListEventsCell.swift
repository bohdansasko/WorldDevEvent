//
//  ListEventsCell.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/29/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

class ListEventsCell: UITableViewCell {
    @IBOutlet weak var smallImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var event: WDEvent? {
        didSet {
            guard let e = event else {
                update(title: nil, description: nil, imageURL: nil)
                return
            }
            update(title: e.title, description: e.description, imageURL: e.smallImageURL)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        event = nil
    }
    
    func update(title: String?, description: String?, imageURL: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        smallImageView.load(withURL: imageURL)
    }
}
