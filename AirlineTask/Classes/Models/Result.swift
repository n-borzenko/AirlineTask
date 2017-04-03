//
//  Result.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(String)
    
    init(_ value: T) {
        self = .success(value)
    }
    
    init(_ error: String) {
        self = .failure(error)
    }
}
