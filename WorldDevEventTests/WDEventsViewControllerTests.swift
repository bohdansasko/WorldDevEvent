//
//  WDEventsViewControllerTests.swift
//  WorldDevEventTests
//
//  Created by Bogdan Sasko on 6/1/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import XCTest
import UIKit

@testable import WorldDevEvent

enum StoryboardName: String {
    case wdScreens = "WDScreens"
}

final class MockWDEventsDataSource: NSObject, WDEventsDataSourceProtocol {
    var events = [WDEvent]()
    
    func event(by indexPath: IndexPath) -> WDEvent {
        return events[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

//viewController.viewModel = WDEventViewModel(with: viewController,
//                                            dataSource: WDEventsDataSource(),
//                                            imageDownloadManager: WDImageDownloadManager.shared

class WDEventsViewControllerTests: XCTestCase {
    var viewController: WDEventViewController!
//    var viewModel: WDEventViewModelProtocol!
//    var configurator: WDEventViewControllerConfiguratorProtocol = WDEventViewControllerConfigurator()
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: StoryboardName.wdScreens.rawValue,
                                      bundle: nil).instantiateViewController(withIdentifier: String(describing: WDEventViewController.self)) as! WDEventViewController
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModelHasDataSourceAfterLoading() {
        // given
        let dataSource = MockWDEventsDataSource()
        viewController.viewModel = WDEventViewModel(with: viewController,
                                                    dataSource: dataSource,
                                                    imageDownloadManager: WDImageDownloadManager.shared)
        
        // when
        let _ = viewController.view
        
        XCTAssertTrue(viewController.listEventsView != nil, "Shouldn't be nil")
        XCTAssertTrue(viewController.listTypeControl != nil, "Shouldn't be nil")
        XCTAssertTrue(viewController.activityIndicator != nil, "Shouldn't be nil")
        XCTAssertTrue(viewController.viewModel != nil, "Shouldn't be nil")
        XCTAssert(viewController.viewModel.viewController === viewController, "Isn't equal")
        
        // then
        
    }
}
