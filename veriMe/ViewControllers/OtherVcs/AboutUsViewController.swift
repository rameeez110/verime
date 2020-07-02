//
//  AboutUsViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 30/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
    }
}

extension AboutUsViewController {
    func setupUI() {
        self.webView.load(URLRequest.init(url: URL.init(string: "http://actice.io/termsandconditions")!))
        
        self.tabBarController?.title = "About Us"
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = false
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back_button_black"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.didTapSideMenu), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item1
    }
    
    @objc func didTapSideMenu(){
        self.navigationController?.popViewController(animated: true)
    }
}
