//
//  WorldDevEventViewController.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/29/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

class WorldDevEventViewController: UIViewController {
    @IBOutlet weak var listEventsView: UITableView!
    
    var eventsDataSource: WDEventsDataSourceProtocol = WDEventsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listEventsView.dataSource = eventsDataSource
        listEventsView.delegate = self
    }
}

extension WorldDevEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let eventCell = cell as? ListEventsCell else {
            print(#function, "can't cast cell to ListEventsCell")
            return
        }
        eventCell.event = eventsDataSource.event(by: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


