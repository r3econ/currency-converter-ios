//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    /// Convenience method for creating simple error alerts
    class func errorAlert(for error: Error) -> UIAlertController {
        // Create an alert
        let alert = UIAlertController(title: nil,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        // OK button
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        return alert
    }
    
}
