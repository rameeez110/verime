//
//  DetailsView.swift
//  veriMe
//
//  Created by Rameez Hasan on 03/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

protocol DetailsViewDelegate: NSObjectProtocol {
    func didTapSend()
}

class DetailsView: UIView{
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var noTextField: UITextField!
    @IBOutlet weak var referenceTextField: UITextField!
    
    weak var delegate: DetailsViewDelegate?
}

extension DetailsView {
    @IBAction func didTapSendButton() {
        self.delegate?.didTapSend()
    }
}
