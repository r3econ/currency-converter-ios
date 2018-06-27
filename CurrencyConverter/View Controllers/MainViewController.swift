//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        WebService().getExchangeRate(for: "USD", success: { exchangeRate in

        }, failure: { error in
            
        })

    }

    // MARK: - UITableViewControllerDataSource
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue and configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyPriceCell")!
        
        cell.textLabel!.text = "100.0"
        
        return cell
    }

}

