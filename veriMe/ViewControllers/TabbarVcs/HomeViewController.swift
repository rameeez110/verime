//
//  HomeViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 29/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var leftDrawerTransition:DrawerTransition!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupSideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI()
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
    }
    func setupUI() {
        self.tabBarController?.title = "Verime"
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
    }
    @objc func didTapAdd(){
        let stroyBoard = UIStoryboard(name: "Settings", bundle: nil)
        let vc = stroyBoard.instantiateViewController(withIdentifier: "ProfileVC")
        DispatchQueue.main.async {
            self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didTapSideMenu(){
        self.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
}
