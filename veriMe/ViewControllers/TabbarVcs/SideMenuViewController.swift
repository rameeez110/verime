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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
