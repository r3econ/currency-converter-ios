//
//  Created by Rafał Sroka on 27.06.18.
//  Copyright © 2018 Rafał Sroka. All rights reserved.
//

import Foundation

struct ExchangeRateCalculator {
    
    /// Calculates the exchange rate for a given value using base currency
    func calculateExchangeRateFor(for value: Float,
                                  with exchangeRate: ExchangeRate) -> [String: Float] {
        // Perform value * ratio operation
        return exchangeRate.rates.mapValues { value * $0 }
    }
    
}
