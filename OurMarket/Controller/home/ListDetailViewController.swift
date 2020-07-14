//
//  ListDetailViewController.swift
//  OurMarket
//
//  Created by binybing on 31/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import WebKit

var boardUserSeqno:Int?
var bId:String?
class ListDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var lblTItle: UILabel!
    @IBOutlet weak var lbluSeqno: UILabel!
    @IBOutlet weak var lblbSeqno: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDM: UIButton!
    @IBOutlet weak var btnFav: UIButton!
    
    var dealComplete:Int?
    var bTitle:String?
    var bContent:String?
    var bPrice:Int?
    var boardSeqno:Int?
    var urlImage:String?
    let sendDM:UIImage? = UIImage(named: "send")
    var btnFavString = ""
    var cnt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetail()
        setButton()
        //setImage(url: urlImage!)
        let setImg = loadWebPage(url: urlImage!)
        webView.load(setImg)
    }
    
    //webView
      func loadWebPage(url:String)->URLRequest{
           let myUrl = URL(string: url)
          //print(myUrl!,"loadWebPage")
           let myRequest = URLRequest(url: myUrl!)
          // print(myRequest)
          
          return myRequest
           
       }
    func setImage(url:String){
         // Put Your Image URL
                let url:NSURL = NSURL(string : url)!
                // It Will turn Into Data
                print(url)
                let imageData : NSData = NSData.init(contentsOf: url as URL)!
                // Data Will Encode into Base64
                
                let str64 = imageData.base64EncodedData(options: .lineLength64Characters)
               
                // Now Base64 will Decode Here
                let data1: NSData = NSData(base64Encoded: str64 , options: .ignoreUnknownCharacters)!
                // turn  Decoded String into Data
                let dataImage = UIImage(data: data1 as Data)
                // pass the data image to image View.:)
               // imageView.image = dataImage
     }
    
    func setDetail(){
        lblTItle.text = bTitle
        lblPrice.text = "\(bPrice!)"
        lblPrice.textAlignment = .right
        //lblbSeqno.text = "\(boardSeqno!)"
        //lbluSeqno.text = "\(boardUserSeqno!)"
        lbluSeqno.text = list.board_Sido
        lblId.text = bId
        tvContent.text = bContent
        tvContent.isEditable = false

    }
    
    
//    func detail(title:String,content:String, price:Int,id:String,bSeqno:Int,uSeqno:Int,cnt:Int,urlImage:String){
//        print(title,content,price,bSeqno,uSeqno,id)
//        self.bTitle = title
//        self.bContent = content
//        self.bPrice = price
//        bId = id
//        self.boardSeqno = bSeqno
//        boardUserSeqno = uSeqno
//        self.cnt = cnt
//        self.urlImage = urlImage
//
//    }
    
    
    
    func getData(list:BoardDB, cnt:Int){
           print(list.board_Content!,list.board_Title!,cnt)
        self.bPrice = list.board_Price
        bId = list.user_Id
        boardUserSeqno = list.board_uSeqno
           self.bTitle = list.board_Title
           self.bContent = list.board_Content
           self.boardSeqno = list.board_Seqno
           self.urlImage = list.board_StrImage
           self.cnt = cnt
           self.dealComplete = list.board_isDone
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
    
    func setButton(){
        
        if cnt%2 == 0 {
            btnFavString = "like_unselected"
            
        }else{
            
            btnFavString = "like_selected"
            
            
        }
        btnFav.setImage(UIImage(named: btnFavString), for: UIControl.State.normal)
        btnDM.setImage(sendDM, for: UIControl.State.normal)
    }
    
 
    
    func insertLikes(){
        let likeInsert = LikesSQL()
        likeInsert.insertLikes(bSeqno: String(boardSeqno!))
    }
    
    func deleteLikes(){
        let likeDelete = LikesSQL()
        likeDelete.deleteLikes(bSeqno: String(boardSeqno!))
    }
    
  
    
}
