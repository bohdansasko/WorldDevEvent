//
//  WDEventsAPI.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/30/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import Foundation

final class WDEventsAPI {
    private init() {}
    
    static let eventsURL = URL(string: "http://smartbox.software/tt/TT.json")!
    
    static func events(from data: Data) -> WDEvents {
        return WDEvents(from: data)
    }
    
    static func fetchEvents(_ completion: @escaping (WDFetchEventsResult) -> Void) {
        URLSession.shared.dataTask(with: WDEventsAPI.eventsURL, completionHandler: { data, response, error in
            guard let data = data else {
                OperationQueue.main.addOperation {
                    completion(.failure(WDFetchEventsError.invalidIncomeData))
                }
                return
            }
            let events = WDEventsAPI.events(from: data)
            OperationQueue.main.addOperation {
                completion(.success(events))
            }
        }).resume()
    }
}
