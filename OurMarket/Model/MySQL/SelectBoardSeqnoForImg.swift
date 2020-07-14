//
//  UserInfo.swift
//  Calander01
//
//  Created by binybing on 19/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import Foundation

protocol SelectBoardSeqno: class {
    func selectBoardSeqno(boardSeqno: Int)
}

class SelectBoardSeqnoForImg: NSObject {
    
    var delegate: SelectBoardSeqno!
    var urlPath = "\(coreIP)selectBoardSeqnoForImage.jsp"

    func selectBSeqno(imgURL:String){
       
        print(" select board Seqno downloaditem start ")
        urlPath += "?id=\(String(describing: user_Seqno!))"
         print(urlPath)
        let url: URL = URL(string: urlPath)!
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print(" Failed to download data")
            }else{
                self.parseJSON(data!,imgURL: imgURL)
                print(" find my masx board seqno is download")
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data,imgURL:String){ //입력수정삭제할때는 필요 없음, 검색할때 필요!!
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        //var checkNum = 0
        // psj
        var checkNum = -1
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            
            if let seqno = jsonElement["board_Seqno"] as? String{
                
                checkNum = Int(seqno)!
                print(" \(checkNum) is my max(bSeqno) check result")
            }
        }
        print("parseJSON")
        DispatchQueue.main.async(execute: {() -> Void in
            print("뭐여...")
            self.delegate.selectBoardSeqno(boardSeqno: checkNum)
            let insertImg = BoardInsert()
            insertImg.insertImage(imgURL: imgURL, bSeqno: checkNum)
             print("뭐여2...")
        })
    }
}

