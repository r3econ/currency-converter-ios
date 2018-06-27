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

extension ExchangeRate: Decodable {
    
    /// Mapping: property <-> JSON field name
    enum CodingKeys: String, CodingKey {
        case baseCurrency = "base"
        case date
        case rates
    }
    
    /// Initializer used by JSONDecoder when mapping JSON into an object
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Base currency
        baseCurrency = try container.decode(String.self, forKey: CodingKeys.baseCurrency)
        
        // Rates dictionary
        rates = try container.decode([String: Float].self, forKey: CodingKeys.rates)
        
        // Apply custom date formatting to extract the date
        let dateString = try container.decode(String.self, forKey: CodingKeys.date)
        date = DateFormatter.shortDateFormatter.date(from: dateString)!
    }
    
}
