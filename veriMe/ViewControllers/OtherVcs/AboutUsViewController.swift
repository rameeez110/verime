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
        self.title = "About Us"
    }
}
