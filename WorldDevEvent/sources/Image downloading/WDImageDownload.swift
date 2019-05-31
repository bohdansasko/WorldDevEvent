//
//  WDImageDownload.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import UIKit

typealias WDImageDownloadHandler = (_ image: UIImage?, _ url: URL, _ indexPath: IndexPath?, _ error: Error?) -> Void

final class WDImageDownloadManager {
    private init() {}
    private var completionHandler: WDImageDownloadHandler?
    
    static let shared = WDImageDownloadManager()
}
