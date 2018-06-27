//
//  Created by Rafał on 01.12.17.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
    case noDataReceived
}

/// Class bridging the communication with external API
class WebService {
    
    private let session: URLSession
    
    init(withConfiguration config: URLSessionConfiguration = URLSessionConfiguration.default) {
        // Create an URL session with a default delegate queue which means
        // that the request completion handlers will be executed on background thread.
        // The network calls are by default made in the background.
        self.session = URLSession(configuration: config,
                                  delegate: nil,
                                  delegateQueue: nil)
    }
    
    /// Request failure handler
    typealias FailureHandler = (Error)->Void
    
    /// Generic request success handler
    typealias SuccessHandler<Value> = (Value)->Void
    
    /// Performs GET request and decodes response trying to create an object
    func getObject<Value: Decodable>(for request: URLRequest,
                                     success: @escaping SuccessHandler<Value>,
                                     failure: @escaping FailureHandler) {
        // Create data task and immediately start it
        session.dataTask(with: request) { (data, response, error) in
            // Handle error
            guard error == nil else {
                // Run failure handler on the main thread
                DispatchQueue.main.async {
                    self.handleErrorInternally(error!, externalHandler: failure)
                }
                return
            }
            
            // No data received
            guard let data = data else {
                // Run failure handler on the main thread
                DispatchQueue.main.async {
                    self.handleErrorInternally(WebServiceError.noDataReceived,
                                               externalHandler: failure)
                }
                return
            }
            
            // Try to decode the response
            do {
                let decodedObject = try JSONDecoder().decode(Value.self, from: data)
                // Call success handler on the main thread
                DispatchQueue.main.async {
                    success(decodedObject)
                }
            } catch let error {
                // Run failure handler on the main thread
                DispatchQueue.main.async {
                    self.handleErrorInternally(error, externalHandler: failure)
                }
            }
            }.resume()
    }
    
    /// Internal error handler. All webservice errors go through this method and are logged.
    private func handleErrorInternally(_ error: Error,
                                       externalHandler: FailureHandler? = nil) {
        // Log error when in debug mode
        #if DEBUG
        print("ERROR: \(error.localizedDescription)")
        #endif
        
        externalHandler?(error)
    }
    
}
