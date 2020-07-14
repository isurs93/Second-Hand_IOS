//
//  BoardWriteViewController.swift
//  OurMarket
//
//  Created by binybing on 30/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import UIKit
import CoreLocation // 자신의 위치를 조회하기 위해서 필요
import MapKit // MapKit 사용하려면 필요

class BoardWriteViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate,UIImagePickerControllerDelegate {
    let locationManager = CLLocationManager() // Location 관련 기능을 담은 클래스 받아오기
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var txtTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicInfo()
        // Do any additional setup after loading the view.
    }
    
    
    func setBasicInfo(){
        txtLocation.text = myLocation
    }
    
    @IBAction func btnLocation(_ sender: UIButton) {
        
        setNewLocation()
        
    }
    
    
    
    func setNewLocation(){
        
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
            print(myLocation," myNewLocation")
        })
        locationManager.stopUpdatingLocation() //이제 그만 멈춰라
        txtLocation.text = myLocation
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //선택한 사진 띄우기
            
            if  let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                print(image)
                
                //imageView.image = image
                
                let data = image.pngData() //img to Data
                print(data!,"image data")
                
                guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
               print("imagePickerControllerDidCancel start")
                print(fileUrl)
               print(fileUrl.lastPathComponent) // get file Name
               // let insertURL = "\(coreIP)"+"\(fileUrl.lastPathComponent)"
                let insertURL = "\(fileUrl.lastPathComponent)"
                print(insertURL)
              // print(fileUrl.pathExtension)     // get file extension
               dismiss(animated: true, completion: nil)
                
                
                imageView.image = image
          
            } else {
                print("There was an error getting the image!")
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    
    
    
    @IBAction func btnLibrary(_ sender: UIButton) {
    
    }
    
    
    
    
    
    
    @IBAction func btnInsert(_ sender: UIButton) {
        
        insert()
        
    }
    func insert(){
        let title = txtTitle.text!
        let content = txtContent.text!
        let price = txtPrice.text!
        let boardInsert = BoardInsert()
        
        if boardInsert.insertBoard(title: title, content: content, price: price, location: myLocation, latitude: myLatitude, longitude: myLongitude){
            
            
            alert(title: "입력성공", message: "게시물을 작성했습니다")
            
            
            
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


