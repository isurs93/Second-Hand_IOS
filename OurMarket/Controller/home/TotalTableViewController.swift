//
//  TotalTableViewController.swift
//  OurMarket
//
//  Created by binybing on 31/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import CoreLocation // 자신의 위치를 조회하기 위해서 필요
import MapKit // MapKit 사용하려면 필요

var myLocation = ""
var myLatitude = ""
var myLongitude = ""
var list = BoardDB()
var myFavList = [MyFavBoardSeqnoDB]()
class TotalTableViewController: UITableViewController,CLLocationManagerDelegate, MKMapViewDelegate,getUserInfoProtocol,totalList,selectMyFav,UISearchBarDelegate,cntFav  {
    
    @IBOutlet var listTableView: UITableView!
    
    var boardList: NSArray = NSArray()
    var boardDB = [BoardDB]()
    var searchResult = [BoardDB]()//search bar
    var countFav = [countFavDB]()
    let locationManager = CLLocationManager()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.rowHeight = 160
        setMyLocation()
        
    }
    
    
    //psj
    override func viewWillAppear(_ animated: Bool) {
        myFavList.removeAll()
        boardDB.removeAll()
        
        
        let totalList = BoardTotalList()
        totalList.delegate = self
        totalList.downloadItems()
        
        let selectMyFav = LikesSQL()
        selectMyFav.delegate = self
        selectMyFav.selectMyLikes()
        
        let cntFav = CountFav()
        cntFav.delegate = self
        cntFav.downloadItems()
        
        self.listTableView.reloadData()
    }
    
    func setMyLocation(){
        
        locationManager.delegate = self //내꺼!!
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //지도의 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() //위치데이터를 확인하기 위해 승인 요청하는 부분
        locationManager.startUpdatingLocation()//위치업데이트 시작
        
    }
    
    //원하는 위도와 경도의 지도 띄우기
    //위도와 경도에 대한 함수
    func goLocation(latitudeValue:CLLocationDegrees,longitudeValue:CLLocationDegrees, delta span: Double)->CLLocationCoordinate2D{ //델타는 지도 크기 정해주는애
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue) //내 위치(쩜) - 지도 그림 그려주는애
        myLatitude = String(pLocation.latitude)
        myLongitude = String(pLocation.longitude)
        
        return pLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last //맨 마지막 위치 - 여기에서 또 찾아야하니까
        //의미가 없는 리턴값을 쓸때는 _ =  로 쓴다
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) //gps가 주는 신호를 받는법
        
        //현재위치의 주소값을 가져와서 찍기
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {(placemarks,erro)->Void in
            let pm = placemarks!.first
            let country = pm!.country
            let city = pm!.administrativeArea
            var address: String = country! + " " + city!
            
            if pm!.locality != nil { //주소값이 지역주소(구주소-~동,~번지)
                address += " "
                address += pm!.locality! //화면 하단에 주소 찍힐거임
            }
            if pm!.thoroughfare != nil { //도로명 주소
                address += " "
                address += pm!.thoroughfare!
            }
            myLocation = address
            //print(address,"feed controller myLocation")
        })
        locationManager.stopUpdatingLocation() //이제 그만 멈춰라
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResult.count
        //return boardList.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TotalTableViewCell
        
        //let list:BoardDB = boardList[indexPath.row] as! BoardDB
        //list = boardList[indexPath.row] as! BoardDB
        list = searchResult[indexPath.row]
        //print(list.board_StrImage!,"tableView image String url")
        //let urlImage = setImageWithURL(url: list.board_StrImage!)
        let requestURL = loadWebPage(url: "\(list.board_StrImage!)")
        cell.webView.load(requestURL)
        cell.webView.sizeToFit()
        // cell.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        cell.lblTitle.text = "\(list.board_Title!)"
        cell.lblPrice.text = "\(list.board_Price!)"
        
        cell.lblTitle.textAlignment = .right
        cell.lblPrice.textAlignment = .right
        
        var btnFavString = "like_unselected"
        
        for i in 0 ..< myFavList.count{
            if  myFavList[i].myFavBoardSeqno == list.board_Seqno{
                btnFavString = "like_selected"
                // print(myFavList[i].myFavBoardSeqno! , list.board_Seqno!)
                break
            }
        }
        
        
        cell.btnFav.setImage(UIImage(named: btnFavString), for: UIControl.State.normal)
        var cntFavInt = 0
        for i in 0 ..< countFav.count{
            if countFav[i].bSeqno == list.board_Seqno{
                cntFavInt = countFav[i].cnt!
            }
        }
        cell.cntFav.text = "\(cntFavInt)"
        cell.cntReply.text = "\(list.board_hit!)"
        
     
        if list.board_isDone == 1{
          
            cell.imageDealComplete.image = UIImage(named: "dealComplete")
            
        }
        
        return cell
    }
    
    //webView
    func loadWebPage(url:String)->URLRequest{
        let myUrl = URL(string: url)
        //print(myUrl!,"loadWebPage")
        let myRequest = URLRequest(url: myUrl!)
        // print(myRequest)
        
        return myRequest
        
    }
    
    
    func checkUrl(url:String)->String{
        var strUrl = url
        let flag = strUrl.hasPrefix("http://localhost:8080/market/")
        if !flag{
            strUrl="http://localhost:8080/market/"+strUrl
        }
        return strUrl
    }
    
    
    func setImageWithURL(url:String)-> UIImage{
        // Put Your Image URL
        let url:NSURL = NSURL(string : url)!
        // It Will turn Into Data
        //print(url)
        let imageData : NSData = NSData.init(contentsOf: url as URL)!
        // Data Will Encode into Base64
        
        let str64 = imageData.base64EncodedData(options: .lineLength64Characters)
        
        // Now Base64 will Decode Here
        let data1: NSData = NSData(base64Encoded: str64 , options: .ignoreUnknownCharacters)!
        // turn  Decoded String into Data
        let dataImage = UIImage(data: data1 as Data)
        // pass the data image to image View.:)
        //viewImage.image = dataImage
        
        
        return dataImage!
        //imageView.image = dataImage
    }
    
    
    
    // userInfo가 조회되지 않았다면 로그인 페이지 이동
    override func viewDidAppear(_ animated: Bool) {
        
        if count == 0{
            guard let uvc = self.storyboard?.instantiateViewController(identifier: "Login")
                else{
                    return
            }
            uvc.modalPresentationStyle = .fullScreen
            self.present(uvc, animated: true)
            count += 1
        }
    }
    //protocol
    func userInfo(items: NSArray) {
        let feedItem: UserInfoDB = items[0] as! UserInfoDB
        
        user_info.user_Seqno = feedItem.user_Seqno
        user_info.user_Id = feedItem.user_Id
        user_info.user_Password = feedItem.user_Password
        user_info.user_Telno = feedItem.user_Telno
        user_info.user_Email = feedItem.user_Email
        user_info.user_Name = feedItem.user_Name
        
    }
    
    func selectMyFav(items: NSArray) {
        myFavList.removeAll()
        for index in 0..<items.count{
            let data: MyFavBoardSeqnoDB = items[index] as! MyFavBoardSeqnoDB
            myFavList.append(data)
        }
        
    }
    
    func cntFav(items: NSArray) {
        countFav.removeAll()
        for index in 0 ..< items.count{
            let data : countFavDB = items[index] as! countFavDB
            countFav.append(data)
        }
    }
    
    
    
    func itemDownloaded(items: NSArray) { //total list
        boardList = items
        
        for i in 0 ..< boardList.count{
            let data = boardList[i] as! BoardDB
            boardDB.append(data)
        }
        searchResult = boardDB
        //  print(boardDB.count, searchResult.count, "itemdownloaded")
        self.listTableView.reloadData()
    }
    
    //search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // print(searchText,"search bar start")
        SearchData(search: searchText)
        
    }
    
    func SearchData(search: String){
        if search == "" {
            searchResult = boardDB
            tableView.reloadData()
            return
        }
        searchResult.removeAll()
        for index in 0..<boardDB.count{
            let content = boardDB[index].board_Content?.components(separatedBy: search)
            let title = boardDB[index].board_Title?.components(separatedBy: search)
            let sido = boardDB[index].board_Sido?.components(separatedBy: search)
            
            if content!.count != 1 || title!.count != 1 || sido!.count != 1{
                searchResult.append(boardDB[index])
            }
        }
        tableView.reloadData()
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //listDetail
        if segue.identifier == "listDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.listTableView.indexPath(for: cell) //몇번째 cell 선택인지 알아내기
            let detailView = segue.destination as! ListDetailViewController //세그로 디테일뷰 컨트롤 연결시키기
            var cnt = 0
            
            print( boardList[indexPath!.row])
            list = boardList[indexPath!.row] as! BoardDB
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
    
    
}


