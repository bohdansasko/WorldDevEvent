//
//  WDEventViewModelProtocol.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

protocol WDEventViewModelProtocol {
    var viewController: WDEventViewController { get set }
    
    var events: WDEvents { get set }
    var dataSource: WDEventsDataSourceProtocol? { get set }
    var imageDownloadManager: WDImageDownloadManagerProtocol { get set }
    
    var currenListType: WDListType { get set }
    
    typealias OnRefreshDataSource = (() -> Void)
    var onRefreshDataSource: OnRefreshDataSource? { get set }
    
    init(with viewController: WDEventViewController, dataSource: WDEventsDataSourceProtocol?, imageDownloadManager: WDImageDownloadManagerProtocol)
    
    func configure()
    func prepareDetailsViewController(with segue: UIStoryboardSegue)
    func showDetailsViewController()
    
    func fetchEvents(_ completion: @escaping (WDFetchEventsResult) -> Void)
}
