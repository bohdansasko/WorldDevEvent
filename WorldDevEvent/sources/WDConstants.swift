//
//  Constants.swift
//  WorldDevEvent
//
//  Created by Bogdan Sasko on 5/31/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import Foundation

enum WDSegues: String {
    case toMapSegue
    case toDetailsSegue
}

enum WDFetchEventsResult {
    case success(WDEvents)
    case failure(Error)
}

enum WDFetchEventsError: String, Error {
    case invalidIncomeData = "Wrong data. Please try again a little bit later."
}
