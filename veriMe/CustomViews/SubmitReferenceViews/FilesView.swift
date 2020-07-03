//
//  FilesView.swift
//  veriMe
//
//  Created by Rameez Hasan on 03/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

protocol FilesViewDelegate: NSObjectProtocol {
    func didTapSubmit()
}

class FilesView:UIView{
    @IBOutlet weak var stackView: UIStackView!
    
    weak var delegate: FilesViewDelegate?
}

extension FilesView {
    @IBAction func didTapSubmitVerification() {
        self.delegate?.didTapSubmit()
    }
}
