//
//  WeatherService.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

class WeatherService {
    
    private let queue: OperationQueue
    private let webTransport = WebTransport()
    private let jsonParser = JsonParser()
    
    private let host = "http://api.openweathermap.org/data/2.5/forecast"
    private let parameters = [
        "units": "metric",
        "lang": "ru",
        "appid": "b72c10b5dcb5793d34b5be892e6bb5d0"
    ]
    
    init(_ queue: OperationQueue) {
        self.queue = queue
    }
    
    func getWeatherData(latitude: Double, longitude: Double,
                        completion: @escaping (Result<[WeatherData]>) -> Void) {
        
        queue.addOperation { [unowned self] in
            var result: Result<[WeatherData]>
            
            var query = [String: Any]()
            self.parameters.forEach { query[$0.key] = $0.value }
            query["lat"] = latitude
            query["lon"] = longitude
            
            let request = RequestParameters(endPoint: self.host, method: .get, parameters: query)
            let response = self.webTransport.request(parameters: request)
            
            var body: WeatherResponse? = nil
            if let bodyString = response.body {
                body = self.jsonParser.convert(string: bodyString)
            }
            
            if let body = body, response.status >= 200 && response.status < 300 {
                result = Result<[WeatherData]>.success(body.dataList)
            } else {
                result = Result<[WeatherData]>.failure(response.error ?? "Parsing error")
            }
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }
}
