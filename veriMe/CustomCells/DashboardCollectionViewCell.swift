//
//  DashboardCollectionViewCell.swift
//  veriMe
//
//  Created by Rameez Hasan on 02/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
