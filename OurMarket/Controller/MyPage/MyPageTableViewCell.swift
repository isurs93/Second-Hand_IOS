//
//  MyPageTableViewCell.swift
//  OurMarket
//
//  Created by binybing on 09/04/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import WebKit

class MyPageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageDealComplete: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var cntFav: UILabel!
    @IBOutlet weak var cntHit: UILabel!
    @IBOutlet weak var btnHit: UIButton!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
