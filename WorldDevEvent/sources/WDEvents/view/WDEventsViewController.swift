//
//  WDEventViewController.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/29/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

final class WDEventViewController: UIViewController {
    @IBOutlet weak var listEventsView: UITableView!
    @IBOutlet weak var listTypeControl: UISegmentedControl!
    
    var viewModel: WDEventViewModelProtocol!
    var configurator: WDEventViewControllerConfiguratorProtocol = WDEventViewControllerConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        viewModel.configure()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        viewModel.prepareDetailsViewController(with: segue)
    }
}

