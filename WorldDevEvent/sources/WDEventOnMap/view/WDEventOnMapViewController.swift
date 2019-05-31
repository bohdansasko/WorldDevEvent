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
    
    var viewModel: WDEventOnMapViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.configure()
        viewModel.showEventOnMap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
