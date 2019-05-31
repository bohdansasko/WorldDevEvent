//
//  WDEventViewControllerConfigurator.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import Foundation

protocol WDEventViewControllerConfiguratorProtocol {
    func configure(with viewController: WDEventViewController)
}

class WDEventViewControllerConfigurator: WDEventViewControllerConfiguratorProtocol {
    func configure(with viewController: WDEventViewController) {
        viewController.viewModel = WDEventViewModel(with: viewController,
                                                    dataSource: WDEventsDataSource())
    }
}
