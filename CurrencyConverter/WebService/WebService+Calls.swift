//
//  Created by Rafał Sroka on 27.06.18.
//  Copyright © 2018 Rafał Sroka. All rights reserved.
//

import Foundation

/// Business logic related request handling
extension WebService {
    
    /// Gets exchange rate for the given base currency
    func getExchangeRate(for baseCurrency: String,
                         success: @escaping SuccessHandler<ExchangeRate>,
                         failure: @escaping FailureHandler) {
        // Create and run the request
        let request = URLRequest.exchangeRateRequest(for: baseCurrency)
        getObject(for: request, success: success, failure: failure)
    }
    
}
