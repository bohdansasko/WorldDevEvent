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
    
    var viewModel: WDEventDetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        viewModel.prepareMapViewController(with: segue)
    }
    
    @IBAction func onTouchButtonShowOnMap(_ sender: Any) {
        viewModel.showMap()
    }
}
