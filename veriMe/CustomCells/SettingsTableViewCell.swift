//
//  SettingsTableViewCell.swift
//  veriMe
//
//  Created by Rameez Hasan on 30/06/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var cellSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
