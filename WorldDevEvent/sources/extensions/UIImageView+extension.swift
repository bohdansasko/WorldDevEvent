//
//  UIImageView+extension.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/29/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(withURL url: String?) {
        guard
            let url = url,
            let imageURL = URL(string: url) else {
                self.image = nil
                return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL, completionHandler: { data, response, error in
            guard let imgData = data else { return }
            let loadedImage = UIImage(data: imgData)
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        })
        task.resume()
    }
}
