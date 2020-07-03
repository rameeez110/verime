//
//  PendingReferenceTableViewCell.swift
//  veriMe
//
//  Created by Rameez Hasan on 03/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class PendingReferenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pedningLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    
    @IBOutlet weak var sendButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
