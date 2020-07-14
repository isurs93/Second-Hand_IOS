//
//  MySQLForMapPage.swift
//  Emoda
//
//  Created by Piano on 2020/03/20.
//  Copyright © 2020 Piano. All rights reserved.
//

import Foundation

protocol myPageTotal: class {
    func itemDownloaded(items:NSArray)
}

class MyPage: NSObject{
    var delegate: myPageTotal!
    let urlPath = "\(coreIP)myPageTotal.jsp?mySeqno=\(user_info.user_Seqno!)"
    
    func downloadItems(){
       // print(urlPath)
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                //print("Failed to download data")
            }else{
               // print("BoardTotalList의 parseJSON() 입장")
                self.parseJSON(data!)
               // print("Data is downloaded")
            }
        }
       // print("BoardTotalList의 downloadItems() 출구")
        task.resume()
    }
  
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
    
        do{ // JSON 필요한 항목 받아오는 것으로 try catch와 같음

            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{

            print(error)
        }
        
        var jsonElement = NSDictionary()
        let boardList = NSMutableArray()
        
       // print(jsonResult.count)
        //print(jsonResult)
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            let query = BoardDB()
            
            if let board_Seqno = jsonElement["board_Seqno"] as? String,
                let board_Title = jsonElement["board_Title"] as? String,
                let board_Content = jsonElement["board_Content"] as? String,
                let board_hit = jsonElement["board_hit"] as? String,
                let board_Sido = jsonElement["board_Sido"] as? String,
                let board_Latitude = jsonElement["board_Latitude"] as? String,
                let board_Longitude = jsonElement["board_Longitude"] as? String,
                let board_InsertDate = jsonElement["board_InsertDate"] as? String,
                let board_isDone = jsonElement["board_isDone"] as? String,
                let board_Price = jsonElement["board_Price"] as? String,
                let user_Id = jsonElement["user_Id"] as? String,
                let board_uSeqno = jsonElement["board_uSeqno"] as? String,
                
                
                let board_StrImage = jsonElement["board_StrImage"] as? String
            
            {

                query.board_Seqno = Int(board_Seqno)
                query.board_Title = board_Title
                query.board_Content = board_Content
                query.board_hit = Int(board_hit)
                query.board_Sido = board_Sido
                query.board_Latitude = Double(board_Latitude)
                query.board_Longitude = Double(board_Longitude)
                query.board_InsertDate = board_InsertDate
                query.board_isDone = Int(board_isDone)
                query.board_Price = Int(board_Price)
                query.user_Id = user_Id
                query.board_uSeqno = Int(board_uSeqno)
                query.board_StrImage = String(board_StrImage)
                
            }
        
            boardList.add(query)
            
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
//            print("MySQLForMapPageModel의 parseJSON 출구")
            print("BoardTotal DispatchQueue")
            self.delegate.itemDownloaded(items: boardList)
        })
    }
    
}
