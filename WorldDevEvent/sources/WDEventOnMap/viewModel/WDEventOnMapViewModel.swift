//
//  WDEventOnMapViewModel.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import MapKit

class WDEventOnMapViewModel: NSObject, WDEventOnMapViewModelProtocol {
    var kEventAnnotationReuseIdentifier: String { return String(describing: WDEventAnnotation.self) }
    
    weak var mapViewController: WDEventOnMapViewController?
    var event: WDEvent
    
    required init(with mapViewController: WDEventOnMapViewController, event: WDEvent) {
        self.mapViewController = mapViewController
        self.event = event
        super.init()
    }
    
    func configure() {
        switch event.type {
        case .event: mapViewController?.title = "Event Location"
        case .shop: mapViewController?.title = "Shop Location"
        }
        
        if #available(iOS 11.0, *) {
            mapViewController?.mapView.register(WDEventAnnotation.self, forAnnotationViewWithReuseIdentifier: kEventAnnotationReuseIdentifier)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func showEventOnMap() {
        let eventCoordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
        let eventAnnotation = WDEventAnnotation(coordinate: eventCoordinate, title: event.title, subtitle: event.shortDescription)
        mapViewController?.mapView.addAnnotation(eventAnnotation)
        mapViewController?.mapView.setRegion(eventAnnotation.region, animated: true)
    }
}
