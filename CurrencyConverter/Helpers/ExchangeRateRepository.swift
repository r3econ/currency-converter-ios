//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

class ExchangeRateRepository {
    
    /// Returns a list of available currency identifiers
    func availableCurrencies() -> [String] {
        // TODO: Extend with API call. Hardcoded for now
        return ["CHF", "EUR", "USD"]
    }
    
}
