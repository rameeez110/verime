//
//  ContactUsViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 30/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    @IBOutlet weak var subjectTextView: UITextView!
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
    }
}
extension ContactUsViewController {
    func setupUI() {
        self.tabBarController?.title = "Contact Us"
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = false
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back_button_black"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.didTapSideMenu), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        self.tabBarController?.navigationItem.leftBarButtonItem = item1
        
        self.subjectTextView.text = "Your Subject"
        self.subjectTextView.textColor = UIColor.lightGray
        
        self.detailTextView.text = "Enter Detail"
        self.detailTextView.textColor = UIColor.lightGray
    }
    @objc func didTapSideMenu(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension ContactUsViewController {
    @IBAction func didTapSend() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ContactUsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}
