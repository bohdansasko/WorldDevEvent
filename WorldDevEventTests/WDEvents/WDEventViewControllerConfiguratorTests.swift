//
//  WDEventViewControllerConfigurator.swift
//  WorldDevEventTests
//
//  Created by Bogdan Sasko on 6/2/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import XCTest
import UIKit

@testable import WorldDevEvent

final class MockWDEventViewControllerConfigurator: WDEventViewControllerConfiguratorProtocol {
    func configure(with viewController: WDEventViewController) {
        viewController.viewModel = WDEventViewModel(with: viewController,
                                                    dataSource: WDEventsDataSource(),
                                                    imageDownloadManager: WDImageDownloadManager.shared)
    }
}

class WDEventViewControllerConfiguratorTests: XCTestCase {
    var viewController: WDEventViewController!
    
    override func setUp() {
        viewController = WDEventViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConfigureMethod() {
        // given
        let configurator = MockWDEventViewControllerConfigurator()
        
        // when
        configurator.configure(with: viewController)
        
        // then
        XCTAssertTrue(viewController.viewModel != nil, "Model should be created")
        XCTAssertTrue(viewController.viewModel.viewController === viewController, "View controlers must be equal")
        XCTAssertNotNil(viewController.viewModel.dataSource, "Data source should be created")
    }
}
