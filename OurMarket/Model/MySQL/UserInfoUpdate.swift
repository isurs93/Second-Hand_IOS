//
//  MySQLForAddPage.swift
//  Emoda
//
//  Created by Piano on 2020/03/21.
//  Copyright © 2020 Piano. All rights reserved.
//

import Foundation

class UserInfoUpdate: NSObject{
    
    func updateUserInfo(seqno: String, pw: String, name: String, tel: String, email: String){
        var result: Bool = true
        var urlPath = "\(coreIP)userInfo_Update.jsp?seqno=\(seqno)&pw=\(pw)&name=\(name)&tel=\(tel)&email=\(email)"
       // print(urlPath,"*******")
        //print(seqno,name,"userInfo update sql")
        // 한글 url encoding 2byte문자를 1byte문자로 변환
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data")
          
            }else{
               print("Data is inserted!")
              
            }
        }
        
        task.resume()
    }

//    func updateUserInfo(seqno: String, pw: String, name: String, tel: String, email: String) -> Bool{
//        var result: Bool = true
//        var urlPath = "\(coreIP)userInfo_Update.jsp?seqno=\(seqno)&pw=\(pw)&name=\(name)&tel=\(tel)&email=\(email)"
//       // print(urlPath,"*******")
//        //print(seqno,name,"userInfo update sql")
//        // 한글 url encoding 2byte문자를 1byte문자로 변환
//        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//
//        let url = URL(string: urlPath)!
//        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
//
//        let task = defaultSession.dataTask(with: url){(data, response, error) in
//            if error != nil{
//                print("Failed to insert data")
//                result = false
//
//            }else{
//               print("Data is inserted!")
//                result = true
//            }
//        }
//        task.resume()
//        return result
//    }
    
}
