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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: WDEventViewModelProtocol!
    var configurator: WDEventViewControllerConfiguratorProtocol = WDEventViewControllerConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        fetchEvents()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        viewModel.prepareDetailsViewController(with: segue)
    }
}

private extension WDEventViewController {
    func prepareView() {
        configurator.configure(with: self)
        
        viewModel.configure()
        viewModel.onRefreshDataSource = {
            self.listEventsView.reloadData()
        }
    }
    
    func fetchEvents() {
        activityIndicator.startAnimating()
        viewModel.fetchEvents({ result in
            self.activityIndicator.stopAnimating()
            self.listTypeControl.sendActions(for: .valueChanged)
            
            if case let .failure(error) = result {
                self.showPromptAlert(with: "World Dev Event", message: error.localizedDescription) { action in
                    print("has been touched button \(action.title ?? "")")
                }
            }
        })
    }
}
