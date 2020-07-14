//
//  FavDetailViewController.swift
//  OurMarket
//
//  Created by binybing on 06/04/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import WebKit

class FavDetailViewController: UIViewController {
    var bTitle:String?
    var bContent:String?
    var bPrice:Int?
    var boardSeqno:Int?
    var urlImage:String?
    let sendDM:UIImage? = UIImage(named: "send")
    var btnFavString = ""
    var addr:String?
    var cnt = 0

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDM: UIButton!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
setButton()
        setLabels()
         let setImg = loadWebPage(url: urlImage!)
        webView.load(setImg)
        // Do any additional setup after loading the view.
    }
    func setLabels(){
        lblTitle.text = bTitle
             lblContent.text = bContent
             lblPrice.text = "\(bPrice!)"
        lblAddress.text = addr
    }
    
    func setButton(){
        if cnt%2 == 0 {
                 btnFavString = "like_unselected"
                 
             }else{
                 
                 btnFavString = "like_selected"
                 
                 
             }
        
        btnFav.setImage(UIImage(named: btnFavString), for: UIControl.State.normal)
            btnDM.setImage(sendDM, for: UIControl.State.normal)
    }
    //webView
         func loadWebPage(url:String)->URLRequest{
              let myUrl = URL(string: url)
             //print(myUrl!,"loadWebPage")
              let myRequest = URLRequest(url: myUrl!)
              print(myRequest)
             
             return myRequest
              
          }
    
    func detail(title:String,content:String, price:Int,id:String,bSeqno:Int,uSeqno:Int,cnt:Int,urlImage:String,addr:String){
           print(title,content,price,bSeqno,uSeqno,id)
           self.bTitle = title
           self.bContent = content
           self.bPrice = price
           bId = id
           self.boardSeqno = bSeqno
           boardUserSeqno = uSeqno
           self.cnt = cnt
           self.urlImage = urlImage
         self.addr = addr
           
       }
    
    @IBAction func btnDMClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnFavClicked(_ sender: UIButton) {
        cnt += 1
               setButton()
               if cnt%2 == 0 && cnt != 0 {
                   deleteLikes()
               }else{
                   insertLikes()
                   
               }
    }
    
    
    func insertLikes(){
        let likeInsert = LikesSQL()
        likeInsert.insertLikes(bSeqno: String(boardSeqno!))
    }
    
    func deleteLikes(){
        let likeDelete = LikesSQL()
        likeDelete.deleteLikes(bSeqno: String(boardSeqno!))
    }
    
//    func setImage(url:String){
//        // Put Your Image URL
//               let url:NSURL = NSURL(string : url)!
//               // It Will turn Into Data
//               print(url)
//               let imageData : NSData = NSData.init(contentsOf: url as URL)!
//               // Data Will Encode into Base64
//
//               let str64 = imageData.base64EncodedData(options: .lineLength64Characters)
//
//               // Now Base64 will Decode Here
//               let data1: NSData = NSData(base64Encoded: str64 , options: .ignoreUnknownCharacters)!
//               // turn  Decoded String into Data
//               let dataImage = UIImage(data: data1 as Data)
//               // pass the data image to image View.:)
//              // imageView.image = dataImage
//    }
    
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
