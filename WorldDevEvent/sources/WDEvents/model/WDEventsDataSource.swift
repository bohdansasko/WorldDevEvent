//
//  WDEventsDataSource.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/29/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

protocol WDEventsDataSourceProtocol: UITableViewDataSource {
    var events: [WDEvent] { get set }
    func event(by indexPath: IndexPath) -> WDEvent
}

class WDEventsDataSource: NSObject {
    private let kListEventCell = "ListEventCell"
    var events: [WDEvent] = []
}

extension WDEventsDataSource: WDEventsDataSourceProtocol {
    func event(by indexPath: IndexPath) -> WDEvent {
        return events[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kListEventCell) else {
            print(#function, "can't find ListEventsCell in the object pool")
            return UITableViewCell()
        }
        return cell
    }
}