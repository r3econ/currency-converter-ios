//
//  Created by Rafał Sroka on 27.06.18.
//  Copyright © 2018 Rafał Sroka. All rights reserved.
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
                         failure: FailureHandler?) {
        // Call remote webservice
        // IDEA: Add a case for loading from the local storage
        getRemoteExchangeRate(for: baseCurrency, success: success, failure: failure)
    }
    
    private func getRemoteExchangeRate(for baseCurrency: String,
                                       success: @escaping SuccessHandler,
                                       failure: FailureHandler?) {
        // Make a call to the web service and forward results to the caller
        webService.getExchangeRate(for: baseCurrency, success: { exchangeRate in
            success(exchangeRate)
            // IDEA: Update the persistence layer here. Store the results
        }, failure: { error in
            failure?(error)
            // IDEA: Decide whether to load local results instead of forwarding the error
        })
    }
    
    private func getLocalExchangeRate(for baseCurrency: String,
                                      success: @escaping SuccessHandler,
                                      failure: FailureHandler?) {
        // IDEA: Load persisted exchange rate
    }
    
    // MARK: - Currencies
    
    /// Returns a list of available currency identifiers
    func availableCurrencies() -> [String] {
        // IDEA: Extend with API call. Hardcoded for now
        return ["CHF", "EUR", "USD", "PLN", "JPY", "GBP", "DKK"]
    }
    
}
