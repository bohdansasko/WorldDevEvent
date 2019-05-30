//
//  WDEventViewModel.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/30/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import Foundation

enum FetchEventsResult {
    case success(WDEvents)
    case failure(Error)
}

enum FetchEventsError: String, Error {
    case invalidIncomeData = "Wrong data. Please try again a little bit later."
}

protocol WDEventViewModelProtocol {
    var events: WDEvents { get set }
    var dataSource: WDEventsDataSourceProtocol? { get set }
    var currenListType: WDListType { get set }
    
    typealias OnRefreshDataSource = (() -> Void)
    var onRefreshDataSource: OnRefreshDataSource? { get set }
    
    func fetchEvents(_ completion: @escaping (FetchEventsResult) -> Void)
}

class WDEventViewModel: WDEventViewModelProtocol {
    var events: WDEvents = WDEvents()
    weak var dataSource: WDEventsDataSourceProtocol?
    var currenListType: WDListType = .events {
        didSet {
            refreshDataSource(by: currenListType)
        }
    }
    
    var onRefreshDataSource: OnRefreshDataSource?
    
    func fetchEvents(_ completion: @escaping (FetchEventsResult) -> Void) {
        URLSession.shared.dataTask(with: WDEventsAPI.eventsURL, completionHandler: { data, response, error in
            guard let data = data else {
                OperationQueue.main.addOperation {
                    completion(.failure(FetchEventsError.invalidIncomeData))
                }
                return
            }
            let events = WDEventsAPI.events(from: data)
            self.events = events
            OperationQueue.main.addOperation {
                completion(.success(events))
            }
        }).resume()
    }
    
    private func refreshDataSource(by listType: WDListType) {
        switch listType {
        case .events: dataSource?.events = events.get(by: .event)
        case .shops: dataSource?.events = events.get(by: .shop)
        }
        onRefreshDataSource?()
    }
}
