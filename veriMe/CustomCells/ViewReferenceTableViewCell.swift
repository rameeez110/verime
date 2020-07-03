//
//  ViewReferenceTableViewCell.swift
//  veriMe
//
//  Created by Rameez Hasan on 03/07/2020.
//  Copyright © 2020 Rameez Hasan. All rights reserved.
//

import UIKit

class ViewReferenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var overallLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
