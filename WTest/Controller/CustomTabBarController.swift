//
//  CustomTabBarController.swift
//  WTest
//
//  Created by Mário Rodrigues on 10/10/2018.
//  Copyright © 2018 Mário Rodrigues. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate the table view
        let postalCodeTableViewController = PostalCodeTableViewController(style: .plain)
        
        // Create a navigation controller that manages the different sections
        let navigationController = UINavigationController(rootViewController: postalCodeTableViewController)
        
        navigationController.title = "Postal Codes"
        navigationController.tabBarItem.image = UIImage(named: "postalCodes")
        navigationController.tabBarItem.image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navigationController.navigationBar.barTintColor = UIColor(named: "CTT")

        viewControllers = [navigationController]
    }
}
