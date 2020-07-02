//
//  HomeViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 29/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var referencesButton: UIButton!
    
    var leftDrawerTransition:DrawerTransition!

    var attrs = [
        NSAttributedString.Key.font : UIFont(name: "Comfortaa-Bold", size: 13)!,
        NSAttributedString.Key.foregroundColor : UIColor.systemYellow,
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]

    var attributedString = NSMutableAttributedString(string:"")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupSideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI()
        
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
    }
}

extension HomeViewController {
    func setupSideMenu() {
        let settingsStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sideMenuTableViewController = settingsStoryboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuViewController
        sideMenuTableViewController.tabBarRef = self.tabBarController
        self.leftDrawerTransition = DrawerTransition(target: self, drawer: sideMenuTableViewController)
        self.leftDrawerTransition.setPresentCompletion { print("left present...") }
        self.leftDrawerTransition.setDismissCompletion { print("left dismiss...") }
        self.leftDrawerTransition.edgeType = .left
        self.leftDrawerTransition.presentDuration = 0.345
        self.leftDrawerTransition.dismissDuration = 0.345
        CommonClass.sharedInstance.leftDrawerTransition = self.leftDrawerTransition
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 165, height: 220)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
    }
    func setupUI() {
        self.tabBarController?.title = "Verime"
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        
        let buttonTitleStr = NSMutableAttributedString(string:"References", attributes:attrs)
        attributedString.append(buttonTitleStr)
        referencesButton.setAttributedTitle(attributedString, for: .normal)
    }
}

extension HomeViewController {
    @IBAction func didTapSideMenu() {
        self.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath) as! DashboardCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)
    }
}
