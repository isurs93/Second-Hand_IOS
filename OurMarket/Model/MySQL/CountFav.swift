//
//  MySQLForMapPage.swift
//  Emoda
//
//  Created by Piano on 2020/03/20.
//  Copyright © 2020 Piano. All rights reserved.
//

import Foundation

protocol cntFav: class {
    func cntFav(items:NSArray)
}

class CountFav: NSObject{
    var delegate: cntFav!
    let urlPath = "\(coreIP)cntFav.jsp"
    
    func downloadItems(){
        print(urlPath)
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
            let query = countFavDB()
            
            if let bSeqno = jsonElement["bSeqno"] as? String,
                let cnt = jsonElement["cnt"] as? String
            
            {

                query.bSeqno = Int(bSeqno)
                query.cnt = Int(cnt)
                
            }
        
            boardList.add(query)
            
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
//            print("MySQLForMapPageModel의 parseJSON 출구")
            print("BoardFav DispatchQueue")
            self.delegate.cntFav(items: boardList)
        })
    }
    
}
