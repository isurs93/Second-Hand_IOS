//
//  MyBoardDetailViewController.swift
//  OurMarket
//
//  Created by binybing on 10/04/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import WebKit

import CoreLocation // 자신의 위치를 조회하기 위해서 필요
import MapKit // MapKit 사용하려면 필요
class MyBoardDetailViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    let locationManager = CLLocationManager() // Location 관련 기능을 담은 클래스 받아오기
    
    
    var bTitle:String?
    var bContent:String?
    var bPrice:Int?
    var boardSeqno:Int?
    var urlImage:String?
    let sendDM:UIImage? = UIImage(named: "send")
    var btnFavString = ""
    var dealComplete:Int?
    var sido:String?
    var cnt = 0
    var boardID:String?
    @IBOutlet weak var btnFav: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDM: UIButton!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var imageDealComplete: UIImageView!
    @IBOutlet weak var lblSido: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBoard()
        setButton()
    }
    
    
  
    
    func setBoard(){
        if dealComplete == 1{
            imageDealComplete.image = UIImage(named: "dealComplete")!
        }
        let setImg = loadWebPage(url: urlImage!)
               webView.load(setImg)
        
        lblTitle.text = bTitle
        lblPrice.text = "\(bPrice!)"
        lblPrice.textAlignment = .right
        lblSido.text = sido
        lblID.text = boardID
       
        tvContent.text = bContent
        
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
      
    
    func getData(list:BoardDB, cnt:Int){
        print(list.board_Content!,list.board_Title!,cnt)
        
        self.bTitle = list.board_Title
        self.bContent = list.board_Content
        self.boardSeqno = list.board_Seqno
        self.urlImage = list.board_StrImage
        self.cnt = cnt
        self.dealComplete = list.board_isDone
        self.sido = list.board_Sido
        self.boardID = list.user_Id
        self.bPrice = list.board_Price
       
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
    
    @IBAction func btnLoacation(_ sender: UIButton) {
        setNewLocation()
    }
    
    
    
    //renew my location
    func setNewLocation(){
        // print("set my new location")
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
           // var address: String = country! + " " + city!
            var address: String =  city!
            
            if pm!.locality != nil { //주소값이 지역주소(구주소-~동,~번지)
                address += " "
                address += pm!.locality! //화면 하단에 주소 찍힐거임
            }
            if pm!.thoroughfare != nil { //도로명 주소
                address += " "
                address += pm!.thoroughfare!
            }
            myLocation = address
            // print(myLocation," myNewLocation")
        })
          locationManager.stopUpdatingLocation() //이제 그만 멈춰라
        lblSido.text = myLocation
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
