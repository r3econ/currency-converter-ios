//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation

extension String {
    
    /// Returns a localized name of the currency based on the currency code in the receiver
    var currencyName: String? {
        return NSLocale.current.localizedString(forCurrencyCode: self)
    }
    
    /// Returns a symbol of the currency based on the currency code in the receiver
    var currencySymbol: String {
        // Get all locale identifiers in the system
        let allLocaleIdentifiers = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        
        // Find first locale that matches the currency code
        let locale = allLocaleIdentifiers.first { $0.currencyCode == self }
        
        if let symbol = locale?.currencySymbol {
            return symbol
        } else {
            // Falbback to returning the receiver
            return self
        }
    }

}
