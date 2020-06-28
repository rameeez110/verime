//
//  SingUpViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 28/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension SingUpViewController {
    @IBAction func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapLogin() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func didTapSingUp() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func didTapFacebook() {
        
    }
    @IBAction func didTapGoogle() {
        
    }
    @IBAction func didTapInstagram() {
        
    }
}

