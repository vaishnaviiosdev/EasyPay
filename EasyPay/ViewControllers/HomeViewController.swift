//
//  HomeViewController.swift
//  EasyPay
//
//  Created by Vaishnavi on 12/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = ViewModel()
    var allData = [User]()
    var currentPage = 1
    var isLoading = false

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
    @IBOutlet weak var walletView: GradientView!
    @IBOutlet weak var flightView: MaterialCard!
    @IBOutlet weak var busView: MaterialCard!
    @IBOutlet weak var trainView: MaterialCard!
    @IBOutlet weak var hotelView: MaterialCard!
    @IBOutlet weak var qrCodeView: UIView!
    @IBOutlet weak var copyView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var mobileView: MaterialCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setCornerRadius(VIEW: self.walletView, iphone: 20, ipad: 40)
        self.setCornerRadius(VIEW: self.ticketBookingView, iphone: 10, ipad: 20)
        self.setCornerRadius(VIEW: self.flightView, iphone: 10, ipad: 20)
        self.setCornerRadius(VIEW: self.busView, iphone: 10, ipad: 20)
        self.setCornerRadius(VIEW: self.trainView, iphone: 10, ipad: 20)
        self.setCornerRadius(VIEW: self.hotelView, iphone: 10, ipad: 20)
        self.setCornerRadius(VIEW: self.receiveMoneyView, iphone: 10, ipad: 20)
        self.setCornerRadius(VIEW: self.qrCodeView, iphone: 20, ipad: 40)
        self.setCornerRadius(VIEW: self.copyView, iphone: 20, ipad: 40)
        self.setCornerRadius(VIEW: self.shareView, iphone: 20, ipad: 40)
        self.setCornerRadius(VIEW: self.billPaymentsView, iphone: 10, ipad: 20)
        self.setCornerRadius(VIEW: self.mobileView, iphone: 10, ipad: 10)
        self.setCornerRadius(VIEW: self.recentTransactionView, iphone: 10, ipad: 20)
        self.setCornerRadius(VIEW: self.linkAccountView, iphone: 12, ipad: 25)
        self.setCornerRadius(VIEW: self.newAccountView, iphone: 12, ipad: 25)
        
        self.moreView.layer.borderWidth = 0.5
        self.linkAccountView.layer.borderWidth = 1
        self.billPaymentsView.layer.borderWidth = 0.5
        self.ticketBookingView.layer.borderWidth = 0.5
        self.recentTransactionView.layer.borderWidth = 0.5
        
        self.linkAccountView.layer.borderColor = UIColor.white.cgColor
        self.ticketBookingView.layer.borderColor = UIColor.systemGray2.cgColor
        self.moreView.layer.borderColor = UIColor.systemGray2.cgColor
        self.billPaymentsView.layer.borderColor = UIColor.systemGray2.cgColor
        self.recentTransactionView.layer.borderColor = UIColor.systemGray2.cgColor
        
        self.loadMoreData()
    }
    
    func loadMoreData() {
        guard !isLoading else { return }

        isLoading = true
        viewModel.fetchUsers(page: currentPage) { users, hasMore in
            if let users = users {
                self.allData.append(contentsOf: users)
                self.currentPage += 1
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.collectionView.reloadData()

                    if self.allData.isEmpty {
                        self.noDataView.isHidden = false
                        self.mainView.isHidden = true
                    }
                    else {
                        self.noDataView.isHidden = true
                        self.mainView.isHidden = false
                    }
                }
            }
            else {
                self.isLoading = false
            }
        }
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let scrollPosition = scrollView.contentOffset.y
        let threshold = contentHeight - scrollView.frame.size.height * 2

        if scrollPosition > threshold && !isLoading {
            loadMoreData()
        }
    }

    func setImageFromURL(url: String, imageView: UIImageView) {
        guard let imageURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to load image data")
                return
            }
            DispatchQueue.main.async {
                imageView.image = image
                self.setCornerRadiusforImgView(imgVIEW: imageView, iphone: 25, ipad: 50)
            }
        }.resume()
    }
    
    func setCornerRadius(VIEW: UIView, iphone: Int, ipad: Int) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            VIEW.layer.cornerRadius = CGFloat(ipad)
        }
        else {
            VIEW.layer.cornerRadius = CGFloat(iphone)
        }
    }
    
    func setCornerRadiusforImgView(imgVIEW: UIImageView, iphone: Int, ipad: Int) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            imgVIEW.layer.cornerRadius = CGFloat(ipad)
        }
        else {
            imgVIEW.layer.cornerRadius = CGFloat(iphone)
        }
    }
}
    
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcell", for: indexPath) as! collectionviewcell
        let dict = self.allData[indexPath.item]
        cell.userNameLbl.text = dict.login
        self.setImageFromURL(url: dict.avatar_url, imageView: cell.userImage)
        self.setCornerRadius(VIEW: cell.userView, iphone: 25, ipad: 50)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = allData[indexPath.row]
        self.setImageFromURL(url: selectedUser.avatar_url, imageView: self.userProfile)
        self.userNameProfile.text = selectedUser.login
    }
}

class collectionviewcell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userView: UIView!
}


