//
//  ForgetPasswordViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 28/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ForgetPasswordViewController {
    @IBAction func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapSend() {
        self.navigationController?.popViewController(animated: true)
    }
}
