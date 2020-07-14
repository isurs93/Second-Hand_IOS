//
//  UserInfo.swift
//  Calander01
//
//  Created by binybing on 19/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import Foundation

protocol LoginCheckProtocol: class {
    func loginCheckResult(loginResult: Int)
}

class LoginSQL: NSObject {
    
    var delegate: LoginCheckProtocol!
    var urlPath = "\(coreIP)sqlLogin.jsp"
    
    func loginCheck(id:String, pw:String){
       // print(" Login downloaditem start ")
        urlPath += "?id=\(String(describing: id))&pw=\(String(describing: pw))"
        let url: URL = URL(string: urlPath)!
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                //print(" Failed to download data")
            }else{
                self.parseJSON(data!)
                //print(" data login check download")
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data){ //입력수정삭제할때는 필요 없음, 검색할때 필요!!
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
           // print(error)
        }
        
        var jsonElement = NSDictionary()
        //var checkNum = 0
        // psj
        var checkNum = -1
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            
            if let seqno = jsonElement["user_Seqno"] as? String{
                
                checkNum = Int(seqno)!
                //print(" \(checkNum) login check result")
            }
        }
       // print("parseJSON")
        DispatchQueue.main.async(execute: {() -> Void in
            //print("뭐여...")
            self.delegate.loginCheckResult(loginResult: checkNum)
             //print("뭐여2...")
        })
    }
}

