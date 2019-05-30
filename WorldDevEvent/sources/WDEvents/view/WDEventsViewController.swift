//
//  WDEventViewController.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/29/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

class WDEventViewController: UIViewController {
    @IBOutlet weak var listEventsView: UITableView!
    @IBOutlet weak var listTypeControl: UISegmentedControl!
    
    var viewModel: WDEventViewModelProtocol = WDEventViewModel()
    var eventsDataSource: WDEventsDataSourceProtocol = WDEventsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        listEventsView.dataSource = eventsDataSource
        listEventsView.delegate = self
        
        listTypeControl.selectedSegmentIndex = viewModel.currenListType.rawValue
        listTypeControl.addTarget(self, action: #selector(onListTypeValueChanged(_:)), for: .valueChanged)
        
        viewModel.dataSource = eventsDataSource
        viewModel.onRefreshDataSource = {
            self.listEventsView.reloadData()
        }
        viewModel.fetchEvents({ result in
            switch result {
            case .success: self.listTypeControl.sendActions(for: .valueChanged)
            case .failure(let error): print(error.localizedDescription)
            }
        })
    }
    
    @objc private func onListTypeValueChanged(_ listTypeView: UISegmentedControl) {
        guard let selectedListType = WDListType(rawValue: listTypeView.selectedSegmentIndex) else {
            print(#function, "segment index out of range WDListType")
            return
        }
        viewModel.currenListType = selectedListType
    }
}

extension WDEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let eventCell = cell as? ListEventsCell else {
            print(#function, "can't cast cell to ListEventsCell")
            return
        }
        let event = eventsDataSource.event(by: indexPath)
        eventCell.update(title: event.title,
                         description: event.shortDescription,
                         imageURL: event.smallImageURL)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

