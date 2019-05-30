//
//  WDEvents.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/30/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import Foundation

struct WDEvents {    
    var items: [WDEvent] = []
    
    init() { /* do nothing */ }
    
    init(from data: Data) {
        do {
            items = try JSONDecoder().decode([WDEvent].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func get(by type: WDEvent.WDType) -> [WDEvent] {
        return items.filter({ $0.type == type })
    }
}
