//
//  WDEvent.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/29/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import Foundation

typealias WDLocationDegrees = Double

enum WDListType: Int {
    case events = 0
    case shops
}

struct WDEvent {
    enum WDType {
        case event
        case shop
    }

    let id: Int
    let type: WDEvent.WDType
    let title: String
    let shortDescription: String
    let description: String
    let smallImageURL: String
    let bigImageURL: String
    let latitude: WDLocationDegrees
    let longitude: WDLocationDegrees
}

extension WDEvent: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case title
        case shortDescription
        case description
        case smallImage
        case bigImage
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        shortDescription = try container.decode(String.self, forKey: .shortDescription)
        description = try container.decode(String.self, forKey: .description)
        smallImageURL = try container.decode(String.self, forKey: .smallImage)
        bigImageURL = try container.decode(String.self, forKey: .bigImage)
        
        let strLatitude = try container.decode(String.self, forKey: .latitude)
        latitude = Double(strLatitude) ?? 0
        
        let strLongitude = try container.decode(String.self, forKey: .longitude)
        longitude = Double(strLongitude) ?? 0
        
        let strType = try container.decode(String.self, forKey: .type)
        switch strType {
        case "event": type = .event
        case "shop": type = .shop
        default:
            type = .event
            print("from server has just come wrong event type")
        }
    }
}
