//
//  FavTableViewCell.swift
//  OurMarket
//
//  Created by binybing on 05/04/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import WebKit
class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var imageDealComplete: UIImageView!
    @IBOutlet weak var lblHit: UILabel!
    @IBOutlet weak var lblFav: UILabel!
    @IBOutlet weak var btnHit: UIButton!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
