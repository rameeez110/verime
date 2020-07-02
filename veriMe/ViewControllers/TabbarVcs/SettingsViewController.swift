//
//  SettingsViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 29/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

enum SettingsOptions:Int {
    case Notification = 0,ContactUs,AboutUs
}

struct SettingsViewModel {
    var title = String()
    var type = SettingsOptions.Notification
    var isSwitch = false
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titles = ["Notification","Contact Us","About Us"]
    var dataSource = [SettingsViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.regesterTableViewCells()
        self.mapDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI()
    }
}
extension SettingsViewController {
    func setupUI() {
        self.tabBarController?.title = "Settings"
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = false
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "menu_button_black"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.didTapSideMenu), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)

        self.tabBarController?.navigationItem.leftBarButtonItem = item1
        
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
    }
    @objc func didTapSideMenu(){
        CommonClass.sharedInstance.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
    
    func regesterTableViewCells() {
        let budgetNib = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        self.tableView.tableFooterView = UIView()
        self.tableView.register(budgetNib, forCellReuseIdentifier: "settingsCell")
    }
    func mapDataSource() {
        self.dataSource = [SettingsViewModel]()
        for i in 0..<self.titles.count {
            var model = SettingsViewModel()
            model.title = self.titles[i]
            if i == 0 {
                model.isSwitch = true
            }
            model.type = SettingsOptions(rawValue: i) ?? SettingsOptions.Notification
            self.dataSource.append(model)
        }
        self.tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableViewCell
        let model = self.dataSource[indexPath.row]
        cell.titleLabel.text = model.title
        cell.cellSwitch.isHidden = !model.isSwitch
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = self.dataSource[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if model.type == .AboutUs {
            let vc = storyboard.instantiateViewController(withIdentifier: "AboutUsVC")
            self.navigationController?.pushViewController(vc, animated: true)
        } else if model.type == .ContactUs {
            let vc = storyboard.instantiateViewController(withIdentifier: "ContactUsVC")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60//UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
