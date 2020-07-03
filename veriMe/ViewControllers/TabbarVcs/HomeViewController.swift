//
//  HomeViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 29/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

enum ReferencesViewType: Int {
    case VerifiedReferences = 0,PendingReferences,Submit,Request
}

struct ReferencesViewModel {
    var title = String()
    var type = ReferencesViewType.VerifiedReferences
    var notification = String()
    var imageName = String()
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var referencesButton: UIButton!
    
    var leftDrawerTransition:DrawerTransition!

    var attrs = [
        NSAttributedString.Key.font : UIFont(name: "Comfortaa-Bold", size: 16)!,
        NSAttributedString.Key.foregroundColor : UIColor.systemYellow,
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]

    var attributedString = NSMutableAttributedString(string:"")
    var titles = ["Verified References","Pending References","Submit","Request"]
    var dataSource = [ReferencesViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupSideMenu()
        self.mapDataSource()
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
    func mapDataSource() {
        self.dataSource = [ReferencesViewModel]()
        for i in 0..<self.titles.count {
            var model = ReferencesViewModel()
            model.title = self.titles[i]
            model.type = ReferencesViewType(rawValue: i) ?? ReferencesViewType.VerifiedReferences
            if model.type == .Request {
                model.imageName = "request_icon"
            } else {
                model.imageName = "references_icon"
            }
            self.dataSource.append(model)
        }
        self.collectionView.reloadData()
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
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath) as! DashboardCollectionViewCell
        
        let model = self.dataSource[indexPath.row]
        
        cell.titleLabel.text = model.title
        cell.iconImageView.image = UIImage(named: model.imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch model.type {
        case .VerifiedReferences:
            self.tabBarController?.selectedIndex = 1
        case .PendingReferences:
            let vc = storyboard.instantiateViewController(withIdentifier: "pendingReferencesVC")
            self.navigationController?.pushViewController(vc, animated: true)
        case.Submit:
            let vc = storyboard.instantiateViewController(withIdentifier: "submitReferencesVC")
            self.navigationController?.pushViewController(vc, animated: true)
        case .Request:
            print("")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)
    }
}
