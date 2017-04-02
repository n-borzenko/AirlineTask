//
//  WebTransport.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import Alamofire

class WebTransport {

    private let commonHeaders = [
        "Accept": "application/json"
    ]
    
    private let alamofireQueue = DispatchQueue.global(qos: .utility)
    private let sessionManager: SessionManager
    
    init() {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        for header in commonHeaders {
            defaultHeaders[header.key] = header.value
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        sessionManager = SessionManager(configuration: configuration, serverTrustPolicyManager: nil)
    }
    
    func request(parameters: RequestParameters) -> RequestResult {
        let semaphore = DispatchSemaphore(value: 0)
        var result = RequestResult()
        
        let requestTask = sessionManager.request(parameters.endPoint,
                                            method: parameters.method,
                                            parameters: parameters.parameters,
                                            encoding: URLEncoding(destination: .methodDependent),
                                            headers: parameters.headers)
            .response(queue: alamofireQueue) { [unowned self] response in
                func setUnknownError() {
                    result.error = "Unknown error"
                    semaphore.signal()
                }
                
                guard response.error == nil else {
                    setUnknownError()
                    return
                }
                
                guard let httpResponse = response.response else {
                    setUnknownError()
                    return
                }
                result.status = httpResponse.statusCode
                if httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
                    result.error = "Network error"
                }
                
                guard let data = response.data,
                    let dataString = String.init(data: data, encoding: .utf8) else {
                        setUnknownError()
                        return
                }
                
                result.body = dataString
                semaphore.signal()
        }
        requestTask.resume()
        semaphore.wait()
        return result
    }
}
