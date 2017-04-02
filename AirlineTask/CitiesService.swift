//
//  CitiesService.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

class CitiesService {
    
    private let queue: OperationQueue
    private let webTransport = WebTransport()
    private let jsonParser = JsonParser()
    
    private let host = "http://api.meetup.com/2/cities"
    
    init(_ queue: OperationQueue) {
        self.queue = queue
    }
    
    func getCities(completion: @escaping (Result<[City]>) -> Void) {

        queue.addOperation { [unowned self] in
            var result: Result<[City]>
            let request = RequestParameters(endPoint: self.host, method: .get)
            let response = self.webTransport.request(parameters: request)
            
            var body: CitiesResponse? = nil
            if let bodyString = response.body {
                body = self.jsonParser.convert(string: bodyString)
            }
        
            if let body = body, response.status >= 200 && response.status < 300 {
                result = Result<[City]>.success(body.citiesList)
            } else {
                result = Result<[City]>.failure(response.error ?? "Parsing error")
            }
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }
}
