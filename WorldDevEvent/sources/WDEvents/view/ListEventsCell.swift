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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        update(title: nil, description: nil, imageURL: nil)
    }
    
    func update(title: String?, description: String?, imageURL: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        smallImageView.load(withURL: imageURL)
    }
}
