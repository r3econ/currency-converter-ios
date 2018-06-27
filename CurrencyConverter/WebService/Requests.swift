//
//  Created by Rafał Sroka on 27.06.18.
//  Copyright © 2018 Rafał Sroka. All rights reserved.
//

import Foundation

/// Request factory
extension URLRequest {
    
    // Base URL used for all the requests
    static var baseUrl: URL {
        return URL(string: "https://exchangeratesapi.io/api/")!
    }
    
    // Latest exchange rate for a given base currency
    // E.g. https://exchangeratesapi.io/api/latest?base=USD
    static func exchangeRateRequest(for baseCurrency: String) -> URLRequest {
        // Resolve the url
        let url = URL(string: "latest?base=\(baseCurrency)", relativeTo: baseUrl)!
        return URLRequest(url: url)
    }
    
    // IDEA: Add endpoint for fetching available currencies

}
