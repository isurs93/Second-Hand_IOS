//
//  ListViewController.swift
//  OurMarket
//
//  Created by binybing on 07/04/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import WebKit
var mapToDMChatterSeqno = 0
class ListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var boardList: NSArray = NSArray()
    var boardDB = [BoardDB]()
    
    var bTitle:String?
    var bContent:String?
    var bPrice:Int?
    var boardSeqno:Int?
    var urlImage:String?
    let sendDM:UIImage? = UIImage(named: "send")
    var btnFavString = ""
    var cnt = 0
    
    var latitude:Double?
    var longitude:Double?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lblSido: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDM: UIButton!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self //그냥 뷰에서 table 넣어 쓰면 이거 해주라고....
        tableView.dataSource = self //꼭 해주는거야 알겠니?
    }
    
    func hideAll(){
        lblTitle.isHidden = true
        lblSido.isHidden = true
        txtContent.isHidden = true
        webView.isHidden = true
        btnFav.isHidden = true
        btnDM.isHidden = true
    }
    
    func showAll(){
        lblTitle.isHidden = false
        lblSido.isHidden = false
        txtContent.isHidden = false
        webView.isHidden = false
        btnFav.isHidden = false
        btnDM.isHidden = false
    }
    
    func setDetail(i:Int){
        print("setDetail Start! \(i)")
        lblTitle.text = boardDB[i].board_Title
        lblSido.text = boardDB[i].board_Sido
        txtContent.text = boardDB[i].board_Content
        txtContent.isEditable = false
        print(boardDB[i].board_Content!)
        //let setImg = loadWebPage(url: urlImage!)
        let setImg = loadWebPage(url: boardDB[i].board_StrImage!)
        webView.load(setImg)
        
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear,\(boardDB.count)")
        if boardDB.count >= 2{
            tableViewSlideUp()
            
        }else{
            tableView.isHidden = true
            showAll()
            setDetail(i: 0)
        }
        
    }
    
    
    func tableViewSlideUp(){
        tableViewTopConstraint.constant = 0
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
        hideAll()
        tableView.isHidden = false
        
    }
    
    func getData(boardSeqno:String,latitude:Double,longitude:Double){
        self.boardSeqno = Int(boardSeqno)
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func checkLocation(arr:[BoardDB]){
        boardDB.removeAll()
        boardDB = arr
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        boardDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "townListCell", for: indexPath)
        
        list = boardDB[indexPath.row]
        cell.textLabel!.text = list.board_Title!
        cell.detailTextLabel!.text = "\(list.board_Price!)"
        
        
        return cell
    }
    
    
    //   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //          print("section: \(indexPath.section)")
    //          print("row: \(indexPath.row)")
    //   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print("\(indexPath.row) row clicked ->")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //listDetail
        if segue.identifier == "mapToDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell) //몇번째 cell 선택인지 알아내기
            let detailView = segue.destination as! ListDetailViewController //세그로 디테일뷰 컨트롤 연결시키기
            var cnt = 0
            
            print( boardDB[indexPath!.row])
            list = boardDB[indexPath!.row]
            for i in 0 ..< myFavList.count{
                if  myFavList[i].myFavBoardSeqno == list.board_Seqno{
                    cnt = 1
                    print(myFavList[i].myFavBoardSeqno! , list.board_Seqno!)
                    break
                }
                
            }
            let boardInsert = BoardInsert()
            boardInsert.updateBoardHit(bSeqno: list.board_Seqno!)
            detailView.getData(list: list,cnt:cnt)
            
        }
    }
    
    
    
    
    
    @IBAction func sendDM(_ sender: UIButton) {
        
        print("send DM clicked!")
        mapToDMChatterSeqno = list.board_uSeqno!
        print("\(list.user_Id!),\(list.board_uSeqno!)")
        
    }
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     
     */
    
}
