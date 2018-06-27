//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

class ExchangeRateRepository {
    
    /// Fetch failure handler
    typealias FailureHandler = (Error)->Void
    
    /// Generic fetch success handler
    typealias SuccessHandler = (ExchangeRate)->Void
    
    private let webService = WebService()
    
    // MARK: - Exchange rate
    
    func getExchangeRate(for baseCurrency: String,
                         success: @escaping SuccessHandler,
                         failure: @escaping FailureHandler) {
        // Make a call to the web service and forward results to the caller
        webService.getExchangeRate(for: baseCurrency, success: { exchangeRate in
            success(exchangeRate)
            // TODO: Update the persistence layer here. Store the results
        }, failure: { error in
            failure(error)
        })
    }
    
    // MARK: - Currencies
    
    /// Returns a list of available currency identifiers
    func availableCurrencies() -> [String] {
        // TODO: Extend with API call. Hardcoded for now
        return ["CHF", "EUR", "USD"]
    }
    
}
