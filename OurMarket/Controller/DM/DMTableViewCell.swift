//
//  DMTableViewCell.swift
//  OurMarket
//
//  Created by binybing on 30/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class DMTableViewCell: UITableViewCell {

    @IBOutlet weak var txtDm: UILabel!
    @IBOutlet weak var txtUserId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
