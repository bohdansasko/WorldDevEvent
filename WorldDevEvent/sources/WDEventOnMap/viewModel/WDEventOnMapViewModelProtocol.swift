//
//  WDEventOnMapViewModelProtocol.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import MapKit

protocol WDEventOnMapViewModelProtocol: NSObjectProtocol {
    var kEventAnnotationReuseIdentifier: String { get }
    
    var mapViewController: WDEventOnMapViewController? { get set }
    var event: WDEvent { get set }
    
    init(with mapViewController: WDEventOnMapViewController, event: WDEvent)
    
    func configure()
    func showEventOnMap()
}
