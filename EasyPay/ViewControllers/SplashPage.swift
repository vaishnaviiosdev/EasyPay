//
//  ViewController.swift
//  EasyPay
//
//  Created by Vaishnavi on 12/12/24.
//

import UIKit

class SplashPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didGetStartedBtnTap(_ sender: Any) {
        let HomeVC = storyBd.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        self.navigationController?.pushViewController(HomeVC, animated: false)
    }
}

