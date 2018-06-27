//
//  Created by Rafał on 27.06.18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class CurrencyPickerViewController: UITableViewController {
    
    private var currencies = [String]() {
        didSet {
            guard isViewLoaded else { return }
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Initialization
    
    class func controller(with currencies: [String]) -> CurrencyPickerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the view controller
        let vc = storyboard.instantiateViewController(withIdentifier: "CurrencyPickerViewController") as! CurrencyPickerViewController
        vc.currencies = currencies
        
        return vc
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    // MARK: - UITableViewControllerDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue and configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell")!
        return cell
    }
    
}
