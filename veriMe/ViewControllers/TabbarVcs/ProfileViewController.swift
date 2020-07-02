//
//  ProfileViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 29/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var noTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI()
    }
}
extension ProfileViewController {
    func setupUI() {
        self.tabBarController?.title = "Profile"
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
}
