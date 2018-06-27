//
//  Created by Rafał Sroka on 27.06.18.
//  Copyright © 2018 Rafał Sroka. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /// Formatter handling dates of type: "2018-06-26"
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
}
