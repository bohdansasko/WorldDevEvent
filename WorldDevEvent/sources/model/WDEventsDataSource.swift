//
//  WDEventsDataSource.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/29/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

protocol WDEventsDataSourceProtocol: UITableViewDataSource {
    func event(by indexPath: IndexPath) -> WDEvent
}

class WDEventsDataSource: NSObject {
    var events: [WDEvent] = [
        WDEvent(id: 1, type: .event, title: "Madison Sqaure Garden 2", shortDescription: "11.2.2019", description: "11.2.2019", smallImageURL: "http://mama-studio.com/tt/event1.png", bigImageURL: "http://mama-studio.com/tt/event11.png", latitude: 40.817817, longtitude: 74.251631),
        WDEvent(id: 2, type: .event, title: "Early Winter SHOW", shortDescription: "11.2.2019", description: "21.3.2019", smallImageURL: "http://mama-studio.com/tt/event2.png", bigImageURL: "http://mama-studio.com/tt/event12.png", latitude: 40.817817, longtitude: 74.251631),
        WDEvent(id: 3, type: .event, title: "Christmas DroidConf", shortDescription: "11.2.2019", description: "31.3.2019", smallImageURL: "http://mama-studio.com/tt/event3.png", bigImageURL: "http://mama-studio.com/tt/event13.png", latitude: 40.817817, longtitude: 74.251631)
    ]
    
    private let kListEventCell = "ListEventCell"
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
