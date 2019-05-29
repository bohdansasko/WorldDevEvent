//
//  WDEvent.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/29/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import Foundation

typealias WDLocationDegrees = Double

enum WDCellType {
    case event
    case shop
}

struct WDEvent {
    let id: Int
    let type: WDCellType
    let title: String
    let shortDescription: String
    let description: String
    let smallImageURL: String
    let bigImageURL: String
    let latitude: WDLocationDegrees
    let longtitude: WDLocationDegrees
}


