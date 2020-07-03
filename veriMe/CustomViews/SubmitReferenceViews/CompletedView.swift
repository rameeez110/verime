//
//  CompletedView.swift
//  veriMe
//
//  Created by Rameez Hasan on 03/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

protocol CompletedViewDelegate: NSObjectProtocol {
    func didTapHome()
}

class CompletedView:UIView{
    @IBOutlet weak var stackView: UIStackView!
    
    weak var delegate: CompletedViewDelegate?
}

extension CompletedView {
    @IBAction func didTapHomeButton() {
        self.delegate?.didTapHome()
    }
}
