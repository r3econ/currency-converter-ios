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
    
    /// Prices computed using the fetched echange rate
    private var calculatedPrices = [String: Float]() {
        didSet {
            tableView.reloadData()
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
            // Set the exchange rate, this triggers UI update
            self.exchangeRate = exchangeRate
            
        }, failure: { error in

        })
    }
    
    func calculateCurrentPriceExchangeRate() {
        // Make sure we have a valid exchange rate fetched
        // Otherwise it does not make sense to calculate prices
        guard let rate = exchangeRate else { return }
        
        calculatedPrices = rate.rates
    }

    // MARK: - UITableViewControllerDataSource
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculatedPrices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue and configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyPriceCell")!
        
        // Extract currency and price
        let currencies = Array(calculatedPrices.keys)
        let currencyKey = currencies[indexPath.row]
        let price = calculatedPrices[currencyKey]!
        
        cell.textLabel!.text = "\(price) \(currencyKey)"
        
        return cell
    }

}

