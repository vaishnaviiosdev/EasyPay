//
//  TabBarViewController.swift
//  EasyPay
//
//  Created by Vaishnavi on 13/12/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tabBar = self.tabBarController?.tabBar {
                var frame = tabBar.frame

                // Set height based on device type
                if UIDevice.current.userInterfaceIdiom == .phone {
                    frame.size.height = 50 // Height for iPhone
                } else if UIDevice.current.userInterfaceIdiom == .pad {
                    frame.size.height = 200// Height for iPad
                }
                
                frame.origin.y = self.view.frame.size.height - frame.size.height
                tabBar.frame = frame
            }
    }
}
