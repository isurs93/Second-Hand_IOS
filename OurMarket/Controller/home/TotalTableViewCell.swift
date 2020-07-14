//
//  TotalTableViewCell.swift
//  OurMarket
//
//  Created by binybing on 31/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import WebKit
class TotalTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var btnReply: UIButton!
    @IBOutlet weak var cntFav: UILabel!
    @IBOutlet weak var cntReply: UILabel!
    
    @IBOutlet weak var imageDealComplete: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
