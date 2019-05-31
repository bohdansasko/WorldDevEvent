//
//  WDEventDetailsViewModel.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

class WDEventDetailsViewModel: WDEventDetailsViewModelProtocol {
    weak var viewController: WDEventDetailsViewController!
    
    var event: WDEvent
    
    required init(with viewController: WDEventDetailsViewController, event: WDEvent) {
        self.viewController = viewController
        self.event = event
    }
    
    func configure() {
        switch event.type {
        case .event: viewController.title = "Event"
        case .shop: viewController.title = "Shop"
        }
        
        viewController.bigImageView.load(withURL: event.bigImageURL)
        viewController.titleLabel.text = event.title
        viewController.shortDescriptionLabel.text = event.shortDescription
        viewController.descriptionLabel.text = event.description
    }
    
    func showMap() {
        viewController.performSegue(withIdentifier: WDSegues.toMapSegue.rawValue, sender: self)
    }
    
    func prepareMapViewController(with segue: UIStoryboardSegue) {
        if segue.identifier == WDSegues.toMapSegue.rawValue {
            guard let mapViewController = segue.destination as? WDEventOnMapViewController else {
                return
            }
            mapViewController.viewModel = WDEventOnMapViewModel(with: mapViewController, event: event)
        }
    }
}
