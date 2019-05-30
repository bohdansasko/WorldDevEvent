//
//  WDEventDetailsViewController.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/30/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

class WDEventDetailsViewController: UIViewController {
    var event: WDEvent!
    let kToMapSegue = "toMapSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    private func prepareUI() {
        switch event.type {
        case .event: title = "Event"
        case .shop: title = "Shop"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == kToMapSegue {
            let detailsViewController = segue.destination as! WDEventOnMapViewController
            detailsViewController.event = event
        }
    }
    
    @IBAction func onTouchButtonShowOnMap(_ sender: Any) {
        print(#function)
        performSegue(withIdentifier: kToMapSegue, sender: self)
    }
    
}
