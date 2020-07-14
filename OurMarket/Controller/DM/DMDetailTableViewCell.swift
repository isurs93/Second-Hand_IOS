//
//  DMDetailTableViewCell.swift
//  OurMarket
//
//  Created by binybing on 06/04/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

class DMDetailTableViewCell: UITableViewCell {
 var label = UILabel()
    @IBOutlet weak var chatContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
