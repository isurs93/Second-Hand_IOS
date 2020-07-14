//
//  UserInfo.swift
//  Calander01
//
//  Created by binybing on 19/03/2020.
//  Copyright © 2020 binybing. All rights reserved.
//

import Foundation

protocol SelectChatterID: class {//대화 상대방 ID
    func selectChatterId(chatterID: NSArray)
}

protocol ChatterSeqno:class { // 상대방 시퀀스 번호
    func chatterSeqno(chatterSeqno: Int)
}

protocol ChatList {
     func chatList(items: NSArray)
}

class DMSelect: NSObject {
    
    var delegate: SelectChatterID!
    var delegate1: ChatterSeqno!
    var delegate2: ChatList!
    
    var urlPath = "\(coreIP)"

    func selectMyChatters(){
        print(user_info.user_Id!)
        print(" select chatter downloaditem start ")
        //urlPath += "DMSelectChatter.jsp?mySeqno=\(String(describing: user_Seqno!))&id=\(user_info.user_Id!)"
        urlPath += "DMSelectChatterAndSeqno.jsp?mySeqno=\(String(describing: user_Seqno!))&id=\(user_info.user_Id!)"
         print(urlPath)
        let url: URL = URL(string: urlPath)!
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print(" Failed to download data")
            }else{
                self.parseJSON(data!)
                print(" my chatter data is download")
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
    let dmList = NSMutableArray()
   
     for i in 0..<jsonResult.count{
         jsonElement = jsonResult[i] as! NSDictionary
        let dm = DmDB()
         
         if let user_id = jsonElement["user_id"] as? String,
            let user_Seqno = jsonElement["user_Seqno"] as? String
         {
             
            dm.chatterId = user_id
            dm.chatterSeqno = Int(user_Seqno)
           //  print(" \(user_id),\(user_Seqno) select my chatter result")
         }
        dmList.add(dm)
     }
    // print("parseJSON")
     DispatchQueue.main.async(execute: {() -> Void in
         //print("뭐여...")
            self.delegate.selectChatterId(chatterID: dmList)
    
//            let insertImg = BoardInsert()
//            insertImg.insertImage(imgURL: imgURL, bSeqno: checkNum)
            // print("뭐여2...")
        })
    }
    
    
    func chatterSeqno(chatterID:String){
            print(" select chatter Seqno downloaditem start ")
            urlPath += "DMSelectChatterSeqno.jsp?id=\(chatterID)"
             print(urlPath)
            let url: URL = URL(string: urlPath)!
            
            let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            
            let task = defaultSession.dataTask(with: url){(data, response, error) in
                if error != nil{
                   // print(" Failed to download data")
                }else{
                    self.parseJSON1(data!)
                   // print(" chatter Seqno data is download")
                }
            }
            task.resume()
        }
        
       func parseJSON1(_ data: Data){ //입력수정삭제할때는 필요 없음, 검색할때 필요!!
      var jsonResult = NSArray()
                 do{
                     jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                 }catch let error as NSError{
                     print(error)
                 }
                 
                 var jsonElement = NSDictionary()
                
                 var checkNum = -1
                 
                 for i in 0..<jsonResult.count{
                     jsonElement = jsonResult[i] as! NSDictionary
                     
                     if let seqno = jsonElement["user_Seqno"] as? String{
                         
                         checkNum = Int(seqno)!
                        print(checkNum,"chatter's Seqno")
                         //print(" \(checkNum) login check result")
                     }
                 }
                // print("parseJSON")
                 DispatchQueue.main.async(execute: {() -> Void in
                     //print("뭐여...")
                    self.delegate1.chatterSeqno(chatterSeqno: checkNum)
                   // print("go in to down load chat list func ")
                    self.downLoadChatList(chatterSeqno: checkNum)
                      //print("뭐여2...")
                 })
             }
    
    
        
    func downLoadChatList(chatterSeqno:Int){
           // print(urlPath)

        urlPath = "\(coreIP)SelectDMList.jsp?mySeqno=\(String(describing: user_Seqno!))&chatterSeqno=\(chatterSeqno)"
      //  print(" select chatList downloaditem start ")
       // print(urlPath)
            let url: URL = URL(string: urlPath)!
            let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            
            let task = defaultSession.dataTask(with: url){(data, response, error) in
                if error != nil{
                    //print("Failed to download data")
                }else{
                   // print("BoardTotalList의 parseJSON() 입장")
                    self.parseJSON2(data!)
                   // print("Data is downloaded")
                }
            }
           // print("BoardTotalList의 downloadItems() 출구")
            task.resume()
        }
      
        func parseJSON2(_ data: Data){
            var jsonResult = NSArray()
        
            do{ // JSON 필요한 항목 받아오는 것으로 try catch와 같음

                jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            }catch let error as NSError{

                print(error)
            }
            
            var jsonElement = NSDictionary()
            let chatList = NSMutableArray()
            
           // print(jsonResult.count)
            //print(jsonResult)
            
            for i in 0..<jsonResult.count{
                jsonElement = jsonResult[i] as! NSDictionary
                let query = DmDB()
                
                if let dm_Seqno = jsonElement["dm_Seqno"] as? String,
                    let dm_bSend = jsonElement["dm_bSend"] as? String,
                    let dm_bReceive = jsonElement["dm_bReceive"] as? String,
                    let dm_Content = jsonElement["dm_Content"] as? String,
                    let dm_InsertDate = jsonElement["dm_InsertDate"] as? String,
                    let dm_SendDelete = jsonElement["dm_SendDelete"] as? String,
                    let dm_ReceiveDelete = jsonElement["dm_ReceiveDelete"] as? String,
                    let dm_Title = jsonElement["dm_Title"] as? String
                    
                {

                    query.dm_Seqno = Int(dm_Seqno)
                    query.dm_bSend = Int(dm_bSend)
                    query.dm_bReceive = Int(dm_bReceive)
                    query.dm_Content = String(dm_Content)
                    query.dm_InsertDate = dm_InsertDate
                    query.dm_SendDelete = dm_SendDelete
                    query.dm_ReceiveDelete = dm_ReceiveDelete
                    query.dm_Title = dm_Title
                    //print(dm_Title,dm_Seqno,"DM Select")
                }
            
                chatList.add(query)
            }
            //print(chatList,"chat list downloading")
            
            DispatchQueue.main.async(execute: {() -> Void in
    //            print("MySQLForMapPageModel의 parseJSON 출구")
              //  print("chat list DispatchQueue")
                self.delegate2.chatList(items: chatList)
            })
        }
        
    }




