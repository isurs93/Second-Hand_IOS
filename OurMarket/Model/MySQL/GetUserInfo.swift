//
//  UserInfo.swift
//  Calander01
//
//  Created by binybing on 19/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import Foundation

protocol getUserInfoProtocol: class {
    func userInfo(items:NSArray)
}

class GetUserInfo: NSObject {
    
    var delegate: getUserInfoProtocol!
    var urlPath = "\(coreIP)userInfo_Login.jsp"
    
    func loginCheck(id:String, pw:String){
        // print(" Login check downloaditem start ")
        urlPath += "?user_Id=\(String(describing: id))&user_Pw=\(String(describing: pw))"
        // print(urlPath)
        let url: URL = URL(string: urlPath)!
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                // print(" Failed to download data")
            }else{
                self.parseJSON(data!)
                // print(" data user info download")
            }
        }
        task.resume()
    }
    

        
    func getUpdatedMyInfo(){
        // print(" Login check downloaditem start ")
        print("getUpdatedMyInfo in GetUserInfo Class")
       urlPath = "\(coreIP)selectMyInfo.jsp?uSeqno=\(user_info.user_Seqno!)"
        print(urlPath)
        // print(urlPath)
        let url: URL = URL(string: urlPath)!
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print(" Failed to download data")
            }else{
                self.parseJSON(data!)
                print(" data user info download")
            }
        }
        task.resume()
    }
    
    
    
    func parseJSON(_ data: Data){ //입력수정삭제할때는 필요 없음, 검색할때 필요!!
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        // print("out side of for in parse json")
        
        // print(jsonResult)
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            
            // print(jsonElement)
            
            let query = UserInfoDB()
            
            //print("돌아라ㅏㅏ")
            
            if let user_Seqno = jsonElement["user_Seqno"] as? String,
                let user_Id = jsonElement["user_Id"] as? String,
                let user_Password = jsonElement["user_Password"] as? String,
                let user_Name = jsonElement["user_Name"] as? String,
                let user_Telno = jsonElement["user_Telno"] as? String,
                let user_Email = jsonElement["user_Email"] as? String
            {
                // print("도랏냐*************")
                query.user_Seqno = Int(user_Seqno)
                query.user_Id = user_Id
                query.user_Password = user_Password
                query.user_Name = user_Name
                query.user_Telno = user_Telno
                query.user_Email = user_Email
                
                //print(query.user_Seqno!,query.user_Id!,query.user_Name!)
            }
            locations.add(query)
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.userInfo(items: locations)
        })
    }
}



