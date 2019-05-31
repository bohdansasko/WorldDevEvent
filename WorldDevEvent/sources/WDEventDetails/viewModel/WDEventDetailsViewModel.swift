//
//  WDEventDetailsViewModel.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

final class WDEventDetailsViewModel: WDEventDetailsViewModelProtocol {
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
        
        if iPhoneX() {
            viewController.showMapButton.titleEdgeInsets = UIEdgeInsets(top: -6.5, left: 0, bottom: 0, right: 0)
        } else if iPhone5() {
            viewController.showMapButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        }
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
    
    private func iPhoneX() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436, 2688, 1792: return true
            default: return false
            }
        }
        return false
    }
    
    private func iPhone5() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136: return true
            default: return false
            }
        }
        return false
    }
}
