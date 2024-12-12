//
//  ViewController.swift
//  EasyPay
//
//  Created by Vaishnavi on 12/12/24.
//

import UIKit

class SplashPage: UIViewController {
    
    //var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel = ViewModel()
        //viewModel.fetchUsers()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didGetStartedBtnTap(_ sender: Any) {
        let HomeVC = storyBd.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(HomeVC, animated: false)
    }
    

}

