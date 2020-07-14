//
//  MySQLForAddPage.swift
//  Emoda
//
//  Created by Piano on 2020/03/21.
//  Copyright © 2020 Piano. All rights reserved.
//

import Foundation

class SignUpSQL: NSObject{

    func insertUserInfo(id: String, pw: String, name: String, tel: String, email: String) -> Bool{
        var result: Bool = true
        var urlPath = "\(coreIP)userInfo_SignUp.jsp?id=\(id)&pw=\(pw)&name=\(name)&tel=\(tel)&email=\(email)"
        print(urlPath)
        // 한글 url encoding 2byte문자를 1byte문자로 변환
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data")
                result = false
                
            }else{
               //print("Data is inserted!")
                result = true
            }
        }
        task.resume()
        return result
    }
    
}
