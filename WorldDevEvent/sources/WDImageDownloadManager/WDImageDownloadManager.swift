//
//  WDImageDownload.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

typealias WDImageDownloadHandler = (_ image: UIImage?, _ url: URL, _ indexPath: IndexPath?, _ error: Error?) -> Void

protocol WDImageDownloadManagerProtocol {
    func downloadImage(_ absoluteImageURL: String, indexPath: IndexPath?, _ completion: @escaping WDImageDownloadHandler)
    func slowDownImageDownloadTaskFor(_ absoluteImageURL: String)
}

final class WDImageDownloadManager {
    static let shared = WDImageDownloadManager()
    
    private init() {}
    
    private var completionHandler: WDImageDownloadHandler?
    private let imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.wdDevEvent.imageDownloadQueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    private let imageCache = NSCache<NSString, UIImage>()
}

extension WDImageDownloadManager: WDImageDownloadManagerProtocol {
    func downloadImage(_ absoluteImageURL: String, indexPath: IndexPath?, _ completion: @escaping WDImageDownloadHandler) {
        print("download ", absoluteImageURL)
        completionHandler = completion
        
        guard let url = URL(string: absoluteImageURL) else { return }
        if let cachedImage = imageCache.object(forKey: absoluteImageURL as NSString) {
            print("return cached image for \(url)")
            OperationQueue.main.addOperation {
                self.completionHandler?(cachedImage, url, indexPath, nil)
            }
        } else {
            // check if image currenly downloading and if yes then set high priority
            if let operations = imageDownloadQueue.operations as? [WDOperation],
               let firstOperation = operations.filter({
                    $0.imageURL.absoluteString == url.absoluteString && $0.isActive()
                }).first {
                print("set high priority for \(url)")
                firstOperation.queuePriority = .high
            } else {
                // create new task for download image
                let operation = WDOperation(url: url, indexPath: indexPath)
                if indexPath == nil {
                    operation.queuePriority = .veryHigh
                }
                operation.downloadHandler = { image, url, indexPath, error in
                    if let newImage = image {
                        self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                    }
                    OperationQueue.main.addOperation {
                        self.completionHandler?(image, url, indexPath, error)
                    }
                }
                print("create new task for \(url)")
                imageDownloadQueue.addOperation(operation)
            }
        }
    }
    
    func slowDownImageDownloadTaskFor(_ absoluteImageURL: String) {
        guard let imageURL = URL(string: absoluteImageURL) else {
            return
        }
        if let operations = imageDownloadQueue.operations as? [WDOperation] {
            let executingOperations = operations.filter({
                $0.imageURL.absoluteString == imageURL.absoluteString && $0.isActive()
            })
            guard let operation = executingOperations.first else { return }
            operation.queuePriority = .low
            print("set low priority for", absoluteImageURL)
        }
    }
}
