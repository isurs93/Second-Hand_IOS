//
//  UploadViewController.swift
//  OurMarket
//
//  Created by binybing on 28/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit

import CoreLocation // 자신의 위치를 조회하기 위해서 필요
import MapKit // MapKit 사용하려면 필요

class UploadViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate, MKMapViewDelegate,SelectBoardSeqno{
    
    let locationManager = CLLocationManager() // Location 관련 기능을 담은 클래스 받아오기
    
    func selectBoardSeqno(boardSeqno: Int) {
        print(boardSeqno,"UPload view")
    }
    
    
    var bSeqno = 0
    var insertURL = ""
    
    var data:Data?
    var strFileURL:String?
    
    
    
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicInfo()
        // Do any additional setup after loading the view.
    }
    
    func setBasicInfo(){
        txtLocation.text = myLocation
    }
    @IBAction func chooseImage(_ sender: UIButton) {
        //사진 라이브러리로 고고
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnCamera(_ sender: UIButton) { //시뮬레이터에서는 카메라 노노! 안댕
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.camera
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnLocation(_ sender: UIButton) {
        setNewLocation()
    }
    
    @IBAction func btnInsert(_ sender: UIButton) {
        insert()
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
            // print(myLocation," myNewLocation")
        })
        locationManager.stopUpdatingLocation() //이제 그만 멈춰라
        txtLocation.text = myLocation
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //선택한 사진 띄우기
        
        if  let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //print(image)
            
            
            data = image.pngData() //img to Data
            //print(data!,"image data")
            
            guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
            //print("imagePickerControllerDidCancel start")
            print(fileUrl)
            print(fileUrl.lastPathComponent) // get file Name
            strFileURL = fileUrl.lastPathComponent
            insertURL = "\(coreIP)"+"\(fileUrl.lastPathComponent)"
            print(insertURL)
            // print(fileUrl.pathExtension)     // get file extension
            dismiss(animated: true, completion: nil)
            
            
            
            // Put Your Image URL
            // let url:NSURL = NSURL(string : "http://cctv-sg.com/images/sr/01.jpg")!
            //           let url:NSURL = NSURL(string : "https://newsimg.hankookilbo.com/2016/03/19/201603191476401918_1.jpg")!
            //
            //            // It Will turn Into Data
            //            print(url)
            //            let imageData : NSData = NSData.init(contentsOf: url as URL)!
            //            // Data Will Encode into Base64
            //
            //            let str64 = imageData.base64EncodedData(options: .lineLength64Characters)
            //
            //            // Now Base64 will Decode Here
            //            let data1: NSData = NSData(base64Encoded: str64 , options: .ignoreUnknownCharacters)!
            //            // turn  Decoded String into Data
            //            let dataImage = UIImage(data: data1 as Data)
            //            // pass the data image to image View.:)
            //            //viewImage.image = dataImage
            //
            //            print("====64====")
            //            print (str64)
            //            print(imageData)
            //            print(data1)
            //            print(dataImage!)
            
            imageView.image = image
            
        } else {
            print("There was an error getting the image!")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func insert(){
        let title = txtTitle.text!
        let content = txtContent.text!
        let price = txtPrice.text!
        let boardInsert = BoardInsert()
        
        if boardInsert.insertBoard(title: title, content: content, price: price, location: myLocation, latitude: myLatitude, longitude: myLongitude){
            
            
            alert(title: "입력성공", message: "게시물을 작성했습니다")
            //내 보드 시퀀스 가져오기
            let selectBoardSeqno = SelectBoardSeqnoForImg()
            selectBoardSeqno.delegate = self
            selectBoardSeqno.selectBSeqno(imgURL: insertURL)
            
            print("FTP START")
            var result = false
            let srt = FTPUpload(baseUrl: "ftp://localhost:21/", userName: "biny", password: "qwer", directoryPath: "/market")
            srt.send(data: data!, with: strFileURL!) { (result) in
                if result{
                    print("Success")
                }else{
                    print("Fail")
                }
            }
            
        }else{
            print("실패 ㅠ")
        }
    }
    func alert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {ACTION in
            self.resetPage()
        })
        
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func resetPage(){
        txtTitle.text = ""
        txtContent.text = ""
        txtPrice.text = ""
        imageView.image = nil
        
    }
    
    //    func getImageData(data:Data, strFileURL:String){
    //        var result = false
    //                   let srt = FTPUpload(baseUrl: "ftp://localhost:21/", userName: "biny", password: "qwer", directoryPath: "/market")
    //        srt.send(data: data, with: strFileURL) { (result) in
    //                       if result{
    //                           print("Success")
    //                       }else{
    //                           print("Fail")
    //                       }
    //                   }
    //    }
    
}
