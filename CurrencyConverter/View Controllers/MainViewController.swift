//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {

    private let repository = ExchangeRateRepository()
    
    private var exchangeRate: ExchangeRate? {
        didSet {
            calculateCurrentPriceExchangeRate()
        }
    
    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchExchangeRate()
    }
    
    // MARK: - Data

    private func fetchExchangeRate() {
        repository.getExchangeRate(for: "USD", success: { exchangeRate in

        }, failure: { error in

        })
    }
    
    func calculateCurrentPriceExchangeRate() {
        // Make sure we have a valid exchange rate fetched
        // Otherwise it does not make sense to calculate prices
        guard let rate = exchangeRate else { return }
        
        tableView.reloadData()
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

