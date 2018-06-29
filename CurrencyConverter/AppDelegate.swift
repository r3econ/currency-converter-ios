//
//  Created by Rafał Sroka on 27.06.18.
//  Copyright © 2018 Rafał Sroka. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureAppearance()
        return true
    }

    private func configureAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor(named: "PrimaryColor")
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UIButton.appearance().tintColor = UIColor(named: "PrimaryColor")
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: UIControlState())
    }

}
