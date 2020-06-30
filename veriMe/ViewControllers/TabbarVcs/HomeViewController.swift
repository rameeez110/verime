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
        self.tabBarController?.navigationController?.navigationBar.isHidden = false
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "nav_menu_icon"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.didTapSideMenu), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)

        let btn2 = UIButton(type: .custom)
        btn2.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        btn2.clipsToBounds = true
        btn2.layer.cornerRadius = btn2.frame.size.height / 2
        btn2.addTarget(self, action: #selector(self.didTapAdd), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)

        self.tabBarController?.navigationItem.leftBarButtonItem = item1
        self.tabBarController?.navigationItem.rightBarButtonItem = item2
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
