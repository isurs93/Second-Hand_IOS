//
//  MySQLForAddPage.swift
//  Emoda
//
//  Created by Piano on 2020/03/21.
//  Copyright © 2020 Piano. All rights reserved.
//

import Foundation

class DMSendMessage: NSObject{

    func sendMessage(title: String, content: String, chatter:Int) -> Bool{
        print(title,content,user_info.user_Seqno!,chatter,"DMSend Message")
        var result: Bool = true
        var urlPath = "\(coreIP)dm_SendMessage.jsp?title=\(title)&content=\(content)&sender=\(user_info.user_Seqno!)&receiver=\(chatter)"
        print(urlPath)
        //print(urlPath)
        // 한글 url encoding 2byte문자를 1byte문자로 변환
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data")
                result = false
                
            }else{
               print("Data is inserted!")
                result = true
            }
        }
        task.resume()
        return result
    }
}
