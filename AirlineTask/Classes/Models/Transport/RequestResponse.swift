//
//  RequestResponse.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import Alamofire

struct RequestParameters {
    let endPoint: String
    let method: HTTPMethod
    let headers: [String: String]?
    let parameters: [String: Any]?
    
    init(endPoint: String,
         method: HTTPMethod,
         headers: [String: String]? = nil,
         parameters: [String: Any]? = nil) {
        self.endPoint = endPoint
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
}
