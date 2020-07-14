//
//  MyTownViewController.swift
//  OurMarket
//
//  Created by binybing on 29/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//


import UIKit
import MapKit // MapKit 사용하려면 필요
import CoreLocation // 자신의 위치를 조회하기 위해서 필요
class MyTownViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate,totalList,townList {
    
    
    var feedItem: NSArray = NSArray()
    var boardListMap = [BoardDB]()
    var boardPassData = [BoardDB]()
    var boardSeqnoInArr = ""
    var selecetedLatitude:Double?
    var selectedLongitude:Double?
    
    var showDataList = [BoardDB]()
    
    
    var cnt = 0
    let locationManager = CLLocationManager() // Location 관련 기능을 담은 클래스 받아오기
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let totalList = BoardTotalList()
        totalList.delegate = self
        totalList.downloadItems()
        
        locationManager.delegate = self //내꺼!!
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //지도의 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() //위치데이터를 확인하기 위해 승인 요청하는 부분
        locationManager.startUpdatingLocation()//위치업데이트 시작
        mapView.showsUserLocation = true //내 위치 찍기
        
    }
    
    
    //원하는 위도와 경도의 지도 띄우기
    //위도와 경도에 대한 함수
    func goLocation(latitudeValue:CLLocationDegrees,longitudeValue:CLLocationDegrees, delta span: Double)->CLLocationCoordinate2D{ //델타는 지도 크기 정해주는애
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue) //내 위치(쩜) - 지도 그림 그려주는애
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) //내 범위
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue) //원 그리기
        mapView.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    //위치가 변경되었을 때 지도의 정보를 표시하는 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last //맨 마지막 위치 - 여기에서 또 찾아야하니까
        //의미가 없는 리턴값을 쓸때는 _ =  로 쓴다
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) //gps가 주는 신호를 받는법
        
        //현재위치의 주소값을 가져와서 찍기
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {(placemarks,erro)->Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address: String = country!
            
            if pm!.locality != nil { //주소값이 지역주소(구주소-~동,~번지)
                address += " "
                address += pm!.locality! //화면 하단에 주소 찍힐거임
            }
            if pm!.thoroughfare != nil { //도로명 주소
                address += " "
                address += pm!.thoroughfare!
            }
            //  print(address,"my town controller")
        })
        locationManager.stopUpdatingLocation() //이제 그만 멈춰라
    }
    
    //내가원하는 위치에 꽂을 핀 만들기
    func setAnnotation(latitudeValue:CLLocationDegrees, longitudeValue:CLLocationDegrees, delta span: Double, title strTitle: String, subTitle strSubTitle:String, boardSeqno:Int){
        let annotation = MKPointAnnotation() //얘가 핀 모양
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle+",\(boardSeqno)"
        //annotation. = "\( boardSeqno)"
        mapView.addAnnotation(annotation)
        
    }
    
    // 여러 유저의 위치를 조회되는 크기만큼 반복해서 표시
    func printPin(){
        
        boardListMap.removeAll()
        
        for index in 0..<feedItem.count{
            
            let item: BoardDB = feedItem[index] as! BoardDB
            
            let board_Seqno = Int(item.board_Seqno!)
            let board_Title = String(item.board_Title!)
            let board_Content = String(item.board_Content!)
            let board_hit = Int(item.board_hit!)
            let board_Sido = String(item.board_Sido!)
            let board_Latitude = Double(item.board_Latitude!)
            let board_Longitude = Double(item.board_Longitude!)
            let board_InsertDate = String(item.board_InsertDate!)
            let board_isDone = Int(item.board_isDone!)
            let board_Price = Int(item.board_Price!)
            let user_Id = String(item.user_Id!)
            let board_uSeqno = Int(item.board_uSeqno!)
            let board_StrImage = String(item.board_StrImage!)
            
            boardListMap.append(BoardDB(board_Seqno: board_Seqno, board_Title: board_Title, board_Content: board_Content, board_hit: board_hit, board_Sido: board_Sido, board_Latitude: board_Latitude, board_Longitude: board_Longitude, board_InsertDate: board_InsertDate, board_isDone: board_isDone, board_Price: board_Price, user_Id: user_Id, board_uSeqno: board_uSeqno, board_StrImage: board_StrImage))
            
            setAnnotation(latitudeValue: board_Latitude, longitudeValue: board_Longitude, delta: 0.01, title: "\(board_Title)", subTitle: "\(board_Price)", boardSeqno: board_Seqno)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        showDataList.removeAll()
        
        let selectedAnnotation = view.annotation!
        let subTitle = selectedAnnotation.subtitle!!
      
        let arr = subTitle.split(separator: ",")
        boardSeqnoInArr = String(arr[1])
        selectedLongitude = selectedAnnotation.coordinate.longitude
        selecetedLatitude = selectedAnnotation.coordinate.latitude
        
        for index in 0..<boardListMap.count{
            
            if boardListMap[index].board_Latitude == selecetedLatitude,
                boardListMap[index].board_Longitude == selectedLongitude{
                showDataList.append(boardListMap[index])
            }
        }

//        let totalList = MyTownClickSelecet()
//             totalList.delegate = self
//             print("selected pin location check start!!! ")
//             totalList.downloadItems(latitude: selecetedLatitude!, longitude: selectedLongitude!)
//              print("selected pin location check FIN!!! ")
//
//
//        if cnt == 1{
//            showModal()
//        }
        showModal()
    }
    
    
    
    //protocol
    func itemDownloaded(items: NSArray) { //board total list
        print(items.count,"item downloaed protocol in my town")
        feedItem = items
      
        // 유저 위치 표시
        printPin()
    }
    
    func locationDataDownloaded(items: NSArray) {
        cnt = 1
        print("location data check start protocol")
        boardPassData.removeAll()
        boardPassData = items as! [BoardDB]
           print(boardPassData.count,"item down loaded -  boardPassData.count")
//        for i in 0 ..< boardListMap.count{
//            let data = boardListMap[i]
//            boardListMap.append(data)
//        }
        //showModal()
    }
    
    func showModal(){
        
                let displayVC : ListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "townListView") as! ListViewController
                         displayVC.getData(boardSeqno: boardSeqnoInArr, latitude:selecetedLatitude!, longitude:selectedLongitude!  )
                         displayVC.checkLocation(arr: showDataList)
                         self.present(displayVC, animated: true)
    }
}
