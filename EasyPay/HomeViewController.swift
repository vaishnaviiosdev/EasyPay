//
//  HomeViewController.swift
//  EasyPay
//
//  Created by Neshwa on 12/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = ViewModel()
    var allData = [User]()
    var isLoading = false
    var currentPage = 1
    
    @IBOutlet weak var linkAccountView: UIView!
    @IBOutlet weak var newAccountView: UIView!
    @IBOutlet weak var ticketBookingView: UIView!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var receiveMoneyView: UIView!
    @IBOutlet weak var billPaymentsView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userNameProfile: UILabel!
    @IBOutlet weak var recentTransactionView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var noDataView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.linkAccountView.layer.borderWidth = 1
        self.linkAccountView.layer.borderColor = UIColor.white.cgColor
        self.linkAccountView.layer.cornerRadius = self.linkAccountView.frame.height / 2
        self.newAccountView.layer.cornerRadius = self.newAccountView.frame.height / 2
        self.ticketBookingView.layer.borderWidth = 0.5
        self.ticketBookingView.layer.borderColor = UIColor.systemGray2.cgColor
        self.ticketBookingView.layer.cornerRadius = 10
        self.moreView.layer.borderWidth = 0.5
        self.moreView.layer.borderColor = UIColor.systemGray2.cgColor
        self.moreView.layer.cornerRadius = self.moreView.frame.height / 2
        self.receiveMoneyView.cornerRadius = 10
        self.billPaymentsView.layer.borderWidth = 0.5
        self.billPaymentsView.layer.borderColor = UIColor.systemGray2.cgColor
        self.recentTransactionView.layer.borderWidth = 0.5
        self.recentTransactionView.layer.borderColor = UIColor.systemGray2.cgColor
        viewModel.fetchUsers {
            self.allData = self.viewModel.users
            if self.allData.isEmpty {
                self.noDataView.isHidden = false  // Show "No Data" view
                self.mainView.isHidden = true  // Hide the collection view
            }
            else {
                self.noDataView.isHidden = true   // Hide "No Data" view
                self.mainView.isHidden = false  // Show the collection view
                self.collectionView.reloadData()
            }
             // Reload the collection view on the main thread
        }
    
    }
    
    func setImageFromURL(url: String, imageView: UIImageView) {
        guard let imageURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            // Check if there was any error or the data is nil
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            // Ensure we have valid image data
            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to load image data")
                return
            }
            
            // Update UI on the main thread
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()  // Start the data task
    }
}
    
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcell", for: indexPath) as! collectionviewcell
        let dict = self.allData[indexPath.row]
        cell.userNameLbl.text = dict.login
        self.setImageFromURL(url: dict.avatar_url, imageView: cell.userImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = allData[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! collectionviewcell
        self.setImageFromURL(url: selectedUser.avatar_url, imageView: self.userProfile)
        self.userNameProfile.text = selectedUser.login
    }

}

class collectionviewcell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
}
