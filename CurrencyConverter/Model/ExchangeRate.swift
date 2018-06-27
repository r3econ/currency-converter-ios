//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

/// Struct modelling the exchange rate between two currencies
/// E.g. `EUR/USD: 1.1672`, where `EUR` is the base and `USD` the target currency
struct ExchangeRate {
    
    let baseCurrency: String
    let date: Date
    let rates: [String: Float]
    
}
