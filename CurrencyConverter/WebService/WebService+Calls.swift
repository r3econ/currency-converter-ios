//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

/// Business logic related request handling
extension WebService {
    
    /// Gets eschange rate for the given base currency
    func getExchangeRate(for baseCurrency: String,
                         success: @escaping SuccessHandler<ExchangeRate>,
                         failure: @escaping FailureHandler) {
        // Create and run the request
        getObject(for: URLRequest(url: URL(string: "https://exchangeratesapi.io/api/latest?base=USD")!), success: success, failure: failure)
    }
    
}
