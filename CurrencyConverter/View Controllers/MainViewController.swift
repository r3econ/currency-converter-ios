//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, CurrencyPickerViewControllerDelegate {

    private let repository = ExchangeRateRepository()
    
    private var exchangeRate: ExchangeRate? {
        didSet {
            calculateCurrentPriceExchangeRate()
        }
    }
    
    /// Price entered by the user
    private var price: Float = 1.0 {
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
    
    /// Base currency selected by the user
    private var selectedBaseCurrency = "USD" {
        didSet {
            updateBaseCurrencyButton()
            fetchExchangeRate()
        }
    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchExchangeRate()
        startPeriodicUpdates(timeInterval: 60.0)
    }
    
    // MARK: - Data

    private func fetchExchangeRate(silenceError shouldSilenceError: Bool = false) {
        repository.getExchangeRate(for: selectedBaseCurrency, success: { exchangeRate in
            // Set the exchange rate, this triggers UI update
            self.exchangeRate = exchangeRate
            
        }, failure: { error in
            guard shouldSilenceError == false else {
                return
            }
            
            // Show alert describing the error
            let alert = UIAlertController.errorAlert(for: error)
            self.present(alert, animated: true)
        })
    }
    
    func calculateCurrentPriceExchangeRate() {
        // Make sure we have a valid exchange rate fetched
        // Otherwise it does not make sense to calculate prices
        guard let rate = exchangeRate else { return }
        
        // Calculate the exchange ratio for current price
        calculatedPrices = ExchangeRateCalculator().calculateExchangeRateFor(for: price, with: rate)
    }

    // MARK: - UI Actions
    
    @IBAction func priceTextFieldDidChange(_ textField: UITextField) {
        // Handle case where user clears the text field
        guard let text = textField.text, text.isEmpty == false else {
            price = 0.0
            return
        }
        
        // Make sure it's a  text that can be converted to a number
        guard let newPrice = Float(text) else { return }
        
        // Set new price. This triggers exchange ratio calculation
        price = newPrice
    }
    
    @IBOutlet var baseCurrencyButton: UIButton!
    
    @IBAction func changeBaseCurrencyButtonTapped(sender: Any) {
        // Get available currencies
        let currencies = repository.availableCurrencies()
        
        // Show currency picker
        let currencyPicker = CurrencyPickerViewController.controller(with: currencies)
        currencyPicker.delegate = self
        navigationController!.pushViewController(currencyPicker, animated: true)
    }
    
    private func updateBaseCurrencyButton() {
        baseCurrencyButton.setTitle(selectedBaseCurrency, for: .normal)
    }
    
    // MARK: - Periodic updates

    private var updateTimer: Timer?

    /// Starts a timer that triggers the exchange rate update
    private func startPeriodicUpdates(timeInterval: TimeInterval) {
        guard updateTimer == nil else {
            return
        }
        
        updateTimer = Timer.scheduledTimer(timeInterval: timeInterval,
                                           target: self,
                                           selector: #selector(updateTimerHandler),
                                           userInfo: nil,
                                           repeats: true)
    }
    
    @objc
    func updateTimerHandler() {
        // Fetch exchange rate and ignore potential errors
        // IDEA: The update logic could be handled by the repository. The repository could
        // deliver information about the updates using notifications (NSNotificationCenter)
        fetchExchangeRate(silenceError: true)
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
        
        cell.textLabel!.text = String(format: "%.2f %@", price, currencyKey.currencySymbol)
        cell.detailTextLabel!.text = currencyKey.currencyName
        
        return cell
    }
    
    // MARK: - CurrencyPickerViewControllerDelegate
    
    func currencyPickerViewController(_ controller: CurrencyPickerViewController,
                                      didFinishWithCurrency currency: String) {
        // Set new currency
        selectedBaseCurrency = currency
        
        // Dismiss the picker
        controller.navigationController!.popToViewController(self, animated: true)
    }

}

