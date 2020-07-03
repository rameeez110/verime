//
//  SideMenuViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 29/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

enum SideMenuOptions: Int {
    case EditProfile = 0,ViewRefrence,PendingRefrence,ContactUs,AboutUs
}

struct SideMenuViewModel {
    var title = String()
    var type = SideMenuOptions.EditProfile
    var selected = false
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var imageShadowView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @objc weak var navRef: UINavigationController?
    @objc weak var tabBarRef: UITabBarController?

    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var titles = ["Edit Profile","View References","Pending References","Contact Us","About Us"]
    var dataSource = [SideMenuViewModel]()
    var leftDrawer : DrawerTransition?{
        get{
            guard let navigationVC = self.tabBarRef?.viewControllers?[0] as? UINavigationController else{return nil}
            if let currentVC = navigationVC.viewControllers.filter({$0.isKind(of: HomeViewController.self)}).first as? HomeViewController {
                return currentVC.leftDrawerTransition
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.regesterTableViewCells()
        self.mapDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setupUI()
    }

}

extension SideMenuViewController {
    func setupUI() {
    }
    func regesterTableViewCells() {
        let budgetNib = UINib(nibName: "SideMenuTableViewCell", bundle: nil)
        self.tableView.tableFooterView = UIView()
        self.tableView.register(budgetNib, forCellReuseIdentifier: "sideMenuCell")
    }
    func mapDataSource() {
        self.dataSource = [SideMenuViewModel]()
        for i in 0..<self.titles.count {
            var model = SideMenuViewModel()
            model.title = self.titles[i]
            model.selected = false
            model.type = SideMenuOptions(rawValue: i) ?? SideMenuOptions.EditProfile
            self.dataSource.append(model)
        }
        self.tableView.reloadData()
    }
}

extension SideMenuViewController {
}

extension SideMenuViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as! SideMenuTableViewCell
        let model = self.dataSource[indexPath.row]
        cell.titleLabel.text = model.title
        cell.dotImageView.isHidden = !model.selected
        if model.selected {
            cell.contentView.borderWidth = 0.5
        } else {
            cell.contentView.borderWidth = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = self.dataSource[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch model.type {
        case .EditProfile:
            self.tabBarRef?.selectedIndex = 2
        case .PendingRefrence:
            self.tabBarRef?.selectedIndex = 1
        case .ViewRefrence:
            self.tabBarRef?.selectedIndex = 1
        case .AboutUs:
            self.tabBarRef?.selectedIndex = 3
            let vc = storyboard.instantiateViewController(withIdentifier: "AboutUsVC")
            self.tabBarRef?.navigationController?.pushViewController(vc, animated: true)
        case .ContactUs:
            self.tabBarRef?.selectedIndex = 3
            let vc = storyboard.instantiateViewController(withIdentifier: "ContactUsVC")
            self.tabBarRef?.navigationController?.pushViewController(vc, animated: true)
        }
        
        for i in 0..<self.dataSource.count {
            self.dataSource[i].selected = false
        }
        
        self.dataSource[indexPath.row].selected = true
        tableView.reloadData()
        
        self.leftDrawer?.dismissDrawerViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
