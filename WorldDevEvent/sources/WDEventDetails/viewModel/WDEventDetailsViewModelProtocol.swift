//
//  WDEventDetailsViewModelProtocol.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

protocol WDEventDetailsViewModelProtocol {
    var viewController: WDEventDetailsViewController! { get set }
    var event: WDEvent { get set }
    
    init(with viewController: WDEventDetailsViewController, event: WDEvent)
    
    func configure()
    func showMap()
    func prepareMapViewController(with segue: UIStoryboardSegue)
}
