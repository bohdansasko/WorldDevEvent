//
//  WDEventDetailsViewController.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/30/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

class WDEventDetailsViewController: UIViewController {
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
        
        bigImageView.load(withURL: event.bigImageURL)
        titleLabel.text = event.title
        shortDescriptionLabel.text = event.shortDescription
        descriptionLabel.text = event.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == kToMapSegue {
            guard let detailsViewController = segue.destination as? WDEventOnMapViewController else {
                return
            }
            detailsViewController.viewModel = WDEventOnMapViewModel(with: detailsViewController, event: event)
        }
    }
    
    @IBAction func onTouchButtonShowOnMap(_ sender: Any) {
        print(#function)
        performSegue(withIdentifier: kToMapSegue, sender: self)
    }
}
