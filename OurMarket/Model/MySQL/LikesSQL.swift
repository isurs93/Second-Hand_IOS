//
//  MySQLForAddPage.swift
//  Emoda
//
//  Created by Piano on 2020/03/21.
//  Copyright © 2020 Piano. All rights reserved.
//

import Foundation

protocol selectMyFav: class {
    func selectMyFav(items:NSArray)
}
class LikesSQL: NSObject{
    
    var delegate: selectMyFav!
    
    func insertLikes(bSeqno: String){
       
        var urlPath =
        "\(coreIP)likes_Insert.jsp?bSeqno=\(bSeqno)&uSeqno=\(String(describing: user_Seqno!))"
        print(urlPath)
        //print(urlPath)
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
    
    func deleteLikes(bSeqno: String){
       
        var urlPath =
        "\(coreIP)likes_Delete.jsp?bSeqno=\(bSeqno)&uSeqno=\(String(describing: user_Seqno!))"
        print(urlPath)
        //print(urlPath)
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
   

func selectMyLikes(){
    
    var urlPath = "\(coreIP)likes_Mine.jsp"
       //print("\(user_Seqno!) select My Likes downloaditem start ")
       urlPath += "?id=\(String(describing: user_Seqno!))"
   // urlPath += "?id=1"
       print(urlPath)
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
         let myFav = NSMutableArray()
             
                 //print("out side of for in parse json")
             
                //print(jsonResult)
                 for i in 0..<jsonResult.count{
                     jsonElement = jsonResult[i] as! NSDictionary
                   
                  // print(jsonElement)
                   
                     let query = MyFavBoardSeqnoDB()
                     
                     //print("돌아라ㅏㅏ")
                   
                     if let myFavBoardSeqno = jsonElement["myFavBoardSeqno"] as? String
                     {
                       // print("도랏냐*************")
                         query.myFavBoardSeqno = Int(myFavBoardSeqno)

                         //print(query.user_Seqno!,query.user_Id!,query.user_Name!)
                     }
                     myFav.add(query)
                    //print(myFav)
                 }
                 
                 DispatchQueue.main.async(execute: {() -> Void in
                    print("LikesSQL DispatchQueue")
                     self.delegate.selectMyFav(items: myFav)
                 })
             }
         }




