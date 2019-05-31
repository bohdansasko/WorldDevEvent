//
//  WDEventViewModel.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/30/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

final class WDEventViewModel: NSObject, WDEventViewModelProtocol {
    unowned var viewController: WDEventViewController
    var dataSource: WDEventsDataSourceProtocol?
    
    var events: WDEvents = WDEvents()
    var currenListType: WDListType = .events {
        didSet { refreshDataSource(by: currenListType) }
    }
    private var eventSelectedIndexPath: IndexPath?
    
    var onRefreshDataSource: OnRefreshDataSource?
    
    init(with viewController: WDEventViewController, dataSource: WDEventsDataSourceProtocol?) {
        self.viewController = viewController
        self.dataSource = dataSource
    }
    
    func configure() {
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
        
        viewController.listEventsView.dataSource = dataSource
        viewController.listEventsView.delegate = self
        
        viewController.listTypeControl.selectedSegmentIndex = currenListType.rawValue
        viewController.listTypeControl.addTarget(self, action: #selector(onListTypeValueChanged(_:)), for: .valueChanged)
    }
    
    func prepareDetailsViewController(with segue: UIStoryboardSegue) {
        if segue.identifier == WDSegues.toDetailsSegue.rawValue {
            let detailsViewController = segue.destination as! WDEventDetailsViewController
            guard
                let eventSelectedIndexPath = eventSelectedIndexPath,
                let selectedEvent = dataSource?.event(by: eventSelectedIndexPath) else {
                    return
            }
            detailsViewController.viewModel = WDEventDetailsViewModel(with: detailsViewController,
                                                                      event: selectedEvent)
            self.eventSelectedIndexPath = nil
        }
    }

    func showDetailsViewController() {
        viewController.performSegue(withIdentifier: WDSegues.toDetailsSegue.rawValue, sender: self)
    }
    
    func fetchEvents(_ completion: @escaping (WDFetchEventsResult) -> Void) {
        URLSession.shared.dataTask(with: WDEventsAPI.eventsURL, completionHandler: { data, response, error in
            guard let data = data else {
                OperationQueue.main.addOperation {
                    completion(.failure(WDFetchEventsError.invalidIncomeData))
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
}

private extension WDEventViewModel {
    func refreshDataSource(by listType: WDListType) {
        switch listType {
        case .events: dataSource?.events = events.get(by: .event)
        case .shops: dataSource?.events = events.get(by: .shop)
        }
        onRefreshDataSource?()
    }
    
    @objc func onListTypeValueChanged(_ listTypeView: UISegmentedControl) {
        guard let selectedListType = WDListType(rawValue: listTypeView.selectedSegmentIndex) else {
            print(#function, "segment index out of range WDListType")
            return
        }
        currenListType = selectedListType
    }
}

// MARK: UITableViewDelegate

extension WDEventViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
            let eventCell = cell as? WDListEventsCell,
            let event = dataSource?.event(by: indexPath) else {
            print(#function, "can't cast cell to \(String(describing: WDListEventsCell.self)) or get event")
            return
        }
        
        eventCell.update(title: event.title,
                         description: event.shortDescription,
                         imageURL: event.smallImageURL)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        eventSelectedIndexPath = indexPath
        showDetailsViewController()
    }
}
