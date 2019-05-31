//
//  WDOperation.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

final class WDOperation: Operation {
    var downloadHandler: WDImageDownloadHandler?
    var imageURL: URL!
    private var indexPath: IndexPath?
    
    override var isAsynchronous: Bool {
        return true
    }
    
    private var _executing = false {
        willSet { willChangeValue(forKey: "isExecuting") }
        didSet { didChangeValue(forKey: "isExecuting") }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet { didChangeValue(forKey: "isFinished") }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
    
    required init(url: URL, indexPath: IndexPath?) {
        self.imageURL = url
        self.indexPath = indexPath
    }
    
    override func main() {
        if isCancelled {
            finish(true)
            return
        }
        executing(true)
        downloadImageFromURL()
    }
    
    func downloadImageFromURL() {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: imageURL) { location, response, error in
            if let locationURL = location, let data = try? Data(contentsOf: locationURL) {
                let image = UIImage(data: data)
                self.downloadHandler?(image, self.imageURL, self.indexPath, error)
            }
            self.finish(true)
            self.executing(false)
        }
        downloadTask.resume()
    }
}
