//
//  WDEventOnMapViewController.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit
import MapKit

class WDEventOnMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var event: WDEvent!
    let kEventAnnotationReuseIdentifier = String(describing: WDEventAnnotation.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareMapView()
        showEventOnMap()
    }
    
    private func prepareMapView() {
        mapView.register(WDEventAnnotation.self, forAnnotationViewWithReuseIdentifier: kEventAnnotationReuseIdentifier)
    }
    
    private func showEventOnMap() {
        let eventCoordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
        let eventAnnotation = WDEventAnnotation(coordinate: eventCoordinate, title: event.title, subtitle: event.shortDescription)
        mapView.addAnnotation(eventAnnotation)
        mapView.setRegion(eventAnnotation.region, animated: true)
    }
}

extension WDEventOnMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let eventAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: kEventAnnotationReuseIdentifier) as? MKMarkerAnnotationView else {
            return nil
        }
        eventAnnotation.animatesWhenAdded = true
        eventAnnotation.titleVisibility = .adaptive
        eventAnnotation.subtitleVisibility = .adaptive
        return eventAnnotation
    }
}
