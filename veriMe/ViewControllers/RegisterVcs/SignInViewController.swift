//
//  SignInViewController.swift
//  veriMe
//
//  Created by Rameez Hasan on 28/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension SignInViewController {
    @IBAction func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapLogin() {
        if let delegate = UIApplication.shared.windows.first?.windowScene?.delegate as? SceneDelegate {
            delegate.initializeTabBar()
        }
    }
    @IBAction func didTapForgetPassword() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func didTapFacebook() {
        
    }
    @IBAction func didTapGoogle() {
        
    }
    @IBAction func didTapInstagram() {
        
    }
}

